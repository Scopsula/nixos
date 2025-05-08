{
  xdg.desktopEntries = {
    #waydroid-session-stop = {
      #name = "Stop Waydroid";
      #exec = "waydroid session stop";
      #terminal = false;
    #};

    freetube = {
      name = "FreeTube";
      exec = "freetube --ozone-platform=wayland";
      terminal = false;
    };

    legcord = {
      name = "Legcord";
      exec = "legcord --ozone-platform=wayland";
      terminal = false;
    };
  };
}
