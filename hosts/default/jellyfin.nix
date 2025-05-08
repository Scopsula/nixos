{ pkgs, ... }:

{
  fileSystems."/mnt/media" =
    { device = "/dev/disk/by-uuid/b6acbf2f-d3b0-4358-83e4-5282708bc7bc";
      fsType = "ext4";
    };

  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  users.users.jellyfin = {
    extraGroups = [ "render" "video" ];
  };
}
