{
  programs.waybar = {
    enable = true;
    style = (builtins.readFile ../sources/waybar/style.css);
    settings = [
      {
	layer = "top";
        position = "top";
        height = 26;
        spacing = 4;

        modules-left = [
    	  "river/tags"
    	  "river/mode"
	  "river/layout"
          "tray"
        ];

        modules-right = [
	  "idle_inhibitor"
	  "custom/separator"
          "wireplumber"
          "custom/separator"
          "cpu"
          "custom/separator"
          "memory"
          "custom/separator"
          "temperature"  
	  "custom/separator"
          "clock"
        ];

        "river/tags" = {
    	  num-tags = 9;
        };

        "river/mode" = {
	  format = "{} ";
        };

        "tray" = {
          spacing = 10;
        };

	"idle_inhibitor" = {
	  format = "{icon}";
	  format-icons = {
	    activated = "";
	    deactivated = "";
	  };
	};

        "wireplumber" = {
          format = "{volume}%  ";
	  format-muted = "{volume}%  ";
	  on-click = "pavucontrol";
        };

        "cpu" = {
          format = "{usage}% ";
          tooltip = false;
        };

        "memory" = {
          format = "{}% ";
        };

        "temperature" = {
          format = "{temperatureC}°C ";
	  tooltip = false;
        };

        "clock" = {
          format = "{:%H:%M} 󰥔";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "custom/separator" = {
          format = "|";
        };
      }
    ];
  };
}
