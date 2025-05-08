{
  wayland.windowManager.river = {
    enable = true;
    package = null;

    systemd = {
      variables = [
	"DISPLAY" 
	"WAYLAND_DISPLAY"
	"NIXOS_OZONE_WL"
	"XCURSOR_THEME"
	"XCURSOR_SIZE"
        "XDG_CURRENT_DESKTOP"
      ];

      extraCommands = [
	"systemctl --user import-environment XDG_CURRENT_DESKTOP"
        "systemctl --user stop pipewire wireplumber xremap"
        "systemctl --user start pipewire wireplumber xremap &"
      ];
    };

    settings = {
      xcursor-theme = "Adwaita";
      default-layout = "wideriver";
      background-color = "0x000000";
      set-repeat = "50 300";

      declare-mode = [
        "normal"
        "floating"
        "passthrough"
      ];

      map = {
        normal = {
          "Super Return" = "spawn footclient";
          "Alt Z" = "close";
	  "Super+Shift E" = "exit";
	  "Super+Shift C" = "spawn ./.config/river/init";

	  "Super J" = "focus-view next";
	  "Super K" = "focus-view previous";
	  "Super+Shift J" = "swap next";
	  "Super+Shift K" = "swap previous";

	  "Super O" = "focus-output next";
	  "Super+Shift O" = "send-to-output next";

	  "Super+Shift Return" = "zoom";

	  "Super Space" = "toggle-float";
	  "Super F" = "toggle-fullscreen";

          "Super Up" = ''send-layout-cmd wideriver "--layout monocle"'';
	  "Super Right" = ''send-layout-cmd wideriver "--layout right"'';
          "Super Down" = ''send-layout-cmd wideriver "--layout wide"'';
          "Super Left" = ''send-layout-cmd wideriver "--layout left"'';

	  "Alt Space" = ''send-layout-cmd wideriver "--layout-toggle"'';
	   
	  "Super H" = ''send-layout-cmd wideriver "--ratio -0.025"'';
	  "Super Equal" = ''send-layout-cmd wideriver "--ratio 0.575"'';
	  "Super L" = ''send-layout-cmd wideriver "--ratio +0.025"'';

	  "Super+Shift H" = ''send-layout-cmd wideriver "--count -1"'';
	  "Super+Shift Equal" = ''send-layout-cmd wideriver "--count 1"'';
	  "Super+Shift L" = ''send-layout-cmd wideriver "--count +1"'';

	  "Super E" = ''send-layout-cmd wideriver "--stack even"'';
	  "Super W" = ''send-layout-cmd wideriver "--stack dwindle"'';
	  "Super I" = ''send-layout-cmd wideriver "--stack diminish"'';

	  "Super Z" = "spawn fuzzel";
	  
	  "Super+Alt T" = "spawn 'firefox'";
	  "Super C" = ''spawn 'grimshot copy area' '';
	  "Super+Alt P" = "spawn 'pavucontrol'";
	  "Alt K" = "spawn 'keepassxc'";
	  "Alt L" = "spawn 'swaylock -f -c 000000'";
	  "Super X" = "spawn 'wl-copy -c'";

          "Alt F" = "enter-mode floating";
	  "Super F11" = "enter-mode passthrough";
        };
 
        floating = {

	  "Super H" = "move left 100";
	  "Super J" = "move down 100";
	  "Super K" = "move up 100";
	  "Super L" = "move right 100";

	  "Super+Alt H" = "snap left";
	  "Super+Alt J" = "snap down";
	  "Super+Alt K" = "snap up";
	  "Super+Alt L" = "snap right";

	  "Super+Shift H" = "resize horizontal -100";
	  "Super+Shift J" = "resize vertical 100";
	  "Super+Shift K" = "resize vertical -100";
	  "Super+Shift L" = "resize horizontal 100";

	  "Alt Z" = "close";
	  "Super Space" = "toggle-float";
	  "Super O" = "focus-output next";
	  "Super+Shift O" = "send-to-output next";

	  "Alt F" = "enter-mode normal";
        };

        passthrough = {
	  "Super F11" = "enter-mode normal";
        };
      };

      map-pointer = {
        floating = {
	  "Super BTN_LEFT" = "move-view";
	  "Super BTN_RIGHT" = "resize-view";
	  "Super BTN_MIDDLE" = "toggle-float";
        };

        normal = {
	  "Super BTN_LEFT" = "move-view";
	  "Super BTN_RIGHT" = "resize-view";
	  "Super BTN_MIDDLE" = "toggle-float";
        };
      };

      rule-add = {
        "-app-id" = {
          "'bar'" = "csd";
          "'org.pulseaudio.pavucontrol'" = "float";
          "'org.keepassxc.KeePassXC'" = "float";
          "'qalculate-gtk'" = "float";
        };
      };   

      extraConfig = ''

        wlr-randr --output DP-3 --pos 0,0 --output DP-2 --pos 1920,0
	swaybg -i ~/Pictures/nix-bg.png &

	wideriver \
	    --layout                       left        \
	    --layout-alt                   monocle     \
	    --stack                        even        \
	    --count-master                 1           \
	    --ratio-master                 0.575       \
	    --count-wide                   3           \
	    --ratio-wide                   0.50        \
	    --no-smart-gaps                            \
	    --inner-gaps                   5           \
	    --outer-gaps                   7           \
	    --border-width                 2           \
	    --border-width-monocle         2           \
	    --border-width-smart-gaps      0           \
	    --border-color-focused         "0xbf616a"  \
	    --border-color-focused-monocle "0xbf616a"  \
	    --border-color-unfocused       "0x5e81ac"  \
	    --log-threshold                info        \
	  > "/tmp/wideriver.''${XDG_VTNR}.''${USER}.log" 2>&1 &

	foot --server &
	pkill waybar &

	pkill swayidle
	swayidle -w \
	  timeout 600 'swaylock -f -c 000000' \
	  timeout 605 'wlr-randr --output DP-2 --off --output DP-3 --off' \
	  resume 'wlr-randr --output DP-2 --on --pos 1920,0 --output DP-3 --on --pos 0,0' &

        riverctl rule-add ssd

        for i in $(seq 1 9)
        do
	    tags=$((1 << ($i - 1)))
            riverctl map normal Super $i set-focused-tags $tags
            riverctl map normal Super+Shift $i set-view-tags $tags
            riverctl map normal Super+Control $i toggle-focused-tags $tags
            riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
        done

        for mode in normal locked
        do
            riverctl map $mode None XF86AudioRaiseVolume  spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.2'
            riverctl map $mode None XF86AudioLowerVolume  spawn 'wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.2'
        done

	gsettings set org.gnome.desktop.wm.preferences button-layout ""
      '';

      spawn = [
        ''"GTK_THEME=Adwaita:dark waybar"''
      ];
    };
  };  
}

