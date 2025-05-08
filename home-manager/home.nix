{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nixvim.homeManagerModules.nixvim
    inputs.arkenfox.hmModules.default
    inputs.catppuccin.homeModules.catppuccin
    ./desktopEntries.nix
    ./programs/default.nix
    ./programs/zsh.nix
    ./programs/gtk.nix
    ./programs/htop.nix
    ./programs/foot.nix
    ./programs/river.nix
    ./programs/firefox.nix
    ./programs/obs.nix
    ./programs/fuzzel.nix
    ./programs/custom-bash-scripts.nix
  ];

  home.persistence."/persist/home/user" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Games"
      "Videos"
      ".nimble"
      ".themes"
      ".mozilla"
      ".config/gh"
      ".config/GIMP"
      ".config/legcord"
      ".config/FreeTube"
      ".config/keepassxc"
      ".config/obs-studio"
      ".config/EasyRPG"
      ".local/share/umu"
      ".local/share/Steam"
      ".local/share/zoxide"
      { directory = ".local/share/steam-jail"; method = "symlink"; }
      ".local/share/PrismLauncher"
    ];
    
    files = [
      ".gitconfig"
    ];

    allowOther = true;
  };

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.05";

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  home.file = {
    "Pictures/nix-bg.png".source = ./sources/nix-bg.png;
  };

  xdg.configFile = {
    "niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink /persist/system/etc/nixos/home-manager/sources/niri/config.kdl;
  };

  xdg.userDirs.enable = true;
}
