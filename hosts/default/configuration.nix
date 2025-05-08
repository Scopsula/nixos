{ lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    inputs.xremap.nixosModules.default
    inputs.lanzaboote.nixosModules.lanzaboote

    inputs.disko.nixosModules.default
    (import ../../disko.nix { device = "/dev/nvme0n1"; })

    ./hardware-configuration.nix
    ./user.nix
    ./firejail.nix
    ./jellyfin.nix
  ];

  environment.systemPackages = [
    pkgs.sbctl
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/etc/mullvad-vpn"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/sbctl"
      "/var/lib/jellyfin"
      "/var/lib/libvirt"
      "/var/lib/systemd/coredump"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  systemd.tmpfiles.rules = [
    "d /persist/home/ 1777 root root -"
    "d /persist/home/<user> 0770 <user> users -"
  ];

  systemd.network = {
    enable = true;
    wait-online.enable = false;

    networks."50-dhcp" = {
      matchConfig.Name = "eth0";
      networkConfig.DHCP = "ipv4";
    };

    links = {
      "01-mac".matchConfig = { PermanentMACAddress = "d8:5e:d3:ad:51:04"; };
      "01-mac".linkConfig = { MACAddressPolicy = "random"; };
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/London";

  systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  security.pam.loginLimits = [
    { domain = "*"; type = "hard"; item = "nofile"; value = "1048576"; }
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.xremap = {
    withWlroots = true;
    serviceMode = "user";
    userName = "user";
    deviceNames = [ "BY Tech Gaming Keyboard" ];
  };

  services.xremap.config.modmap = [ 
    { 
      name = "global"; remap = { "CapsLock" = "Esc"; }; 
    }
  ];
  
  services.mullvad-vpn.enable = true;
  services.dbus.enable = true;
  services.fstrim.enable = true;

  programs.fuse.userAllowOther = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];

  system.stateVersion = "24.11";
}

