{ pkgs, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users.user = {
    isNormalUser = true;
    description = "user";
    shell = pkgs.zsh;
    extraGroups = [ "input" "wheel" "libvirtd" ];
    hashedPasswordFile = "/persist/user/password";
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {inherit inputs;};
  home-manager.users.user = import ../../home-manager/home.nix;

  users.motd = " ";
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    groups = ["wheel"];
    keepEnv = true; 
    persist = true;
  }];

  programs.steam.enable = true;
  programs.niri.enable = true;
  services.gnome.gnome-keyring.enable = false;

  services.mpd = {
    enable = true;
    musicDirectory = "/home/user/Music";
    user = "user";
    extraConfig = ''
      audio_output {
	type "pipewire"
	name "Built-in Audio Analog Stereo"
      }
    '';
  };

  systemd.services.mpd.environment = { 
    XDG_RUNTIME_DIR = "/run/user/1000"; 
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  environment.pathsToLink = [ "/share/zsh" ];
}  
