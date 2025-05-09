{ pkgs, inputs, ... }:

let
  neovimconfig = import ../nixvim;
  nvim = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
    inherit pkgs;
    module = neovimconfig;
  };
in

{
  home.packages = with pkgs; [
    # WM Tools
    wideriver
    wlr-randr
    wl-clipboard
    swaybg
    swayidle
    swaylock
    libnotify
    mako
    lswt

    # CLI Tools
    xdg-utils
    xdg-user-dirs
    radeontop
    unzip
    nvim
    btop
    fastfetch
    moreutils
    libva-utils
    lm_sensors
    doas-sudo-shim
    ripgrep
    jmtpfs
    ffmpeg-full
    yt-dlp
    fzf
    fd
    gh
    cmus
    p7zip
    ncmpcpp
    bubblewrap

    # Desktop
    imv
    mpv
    blanket
    nautilus # Required for xdg-portal-gnome
    xwayland-satellite # Required for xwayland on niri
    pavucontrol
    qalculate-gtk
    libqalculate
    slurp
    legcord
    freetube
    gimp3
    sway-contrib.grimshot
    xorg.xeyes

    # Languages
    nim
    nimble

    # Games
    umu-launcher
    (pkgs.prismlauncher.override { jdks = [ 
      pkgs.temurin-bin-21 
      pkgs.temurin-bin-8 
      pkgs.temurin-bin-17 
      ]; 
    })
  ];
 
  programs.zoxide.enable = true;
  programs.home-manager.enable = true;
}
