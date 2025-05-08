{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "footclient";
	fields = "name";
	match-mode = "exact";
	cache = "/dev/null";
	inner-pad = "5";
	sort-result = false;
	icons-enabled = false;
	match-counter = true;
      };

      border = {
        width = 3;
        radius = 6;
      };

      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
	prompt = "bac2deff";
	placeholder = "7f849cff";
	input = "cdd6f4ff";
        match = "89b4faff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "89b4faff";
	counter = "7f849cff";
        border = "89b4faff";
      };
    };
  };
}
