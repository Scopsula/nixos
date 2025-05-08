{
  services.flatpak = {
    enable = true;
    update.auto.enable = true;
    packages = [
      "com.valvesoftware.Steam"
      "org.keepassxc.KeePassXC"
      "org.easyrpg.player"
    ];
  };
}
