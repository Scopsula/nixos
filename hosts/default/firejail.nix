{ pkgs, ... }:

{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      easyrpg-player = {
        executable = "${pkgs.easyrpg-player}/bin/easyrpg-player";
        profile = "${pkgs.firejail}/etc/firejail/default.profile";
	desktop = "${pkgs.easyrpg-player}/share/applications/easyrpg-player.desktop";
	extraArgs = [ "--net=none" ];
      };

      steam = {
        executable = "${pkgs.steam}/bin/steam";
        profile = null; #"${pkgs.firejail}/etc/firejail/steam.profile";
	desktop = "${pkgs.steam}/share/applications/steam.desktop";
	extraArgs = [ "--private=~/.local/share/steam-jail" "--noprofile" "--rlimit-nofile=1048576" ];
      };

      keepassxc = {
        executable = "${pkgs.keepassxc}/bin/keepassxc";
        profile = "${pkgs.firejail}/etc/firejail/keepassxc.profile";
	desktop = "${pkgs.keepassxc}/share/applications/org.keepassxc.KeePassXC.desktop";
	extraArgs = [ "--net=none" ];
      };
    };
  };

  environment.etc = {
    "firejail/firejail.config".text = ''
      force-nonewprivs yes
    '';

    "firejail/steam.local".text = ''
      ignore mkdir
      ignore mkfile
      whitelist /tmp/dbus-*
    '';
  };
}
