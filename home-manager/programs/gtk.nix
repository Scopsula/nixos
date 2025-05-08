{ pkgs, inputs, ... }:

{
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      package = pkgs.nerd-fonts.dejavu-sans-mono;
      name = "DejaVuSansNerdFont";
      size = 10;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  catppuccin.gtk = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
    size = "standard";
    tweaks = [ "normal" ];
  };

  home.sessionVariables = {
    GTK_THEME = "catppuccin-mocha-blue-standard+normal";
  };
}
