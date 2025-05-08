{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    history.path = "$HOME/.cache/zsh_history";

    completionInit = "autoload -U compinit && zstyle ':completion:*' menu select && compinit && _comp_options+=(globdots)";

    shellAliases = {
      niri = "dbus-run-session niri --session";
      up = "doas nix flake update --flake /etc/nixos";
      rs = "doas nixos-rebuild switch";
      rb = "doas nixos-rebuild boot";
      gc = "nix store gc";
      cg = "nix-collect-garbage -d";
      cg-r = "doas nix-collect-garbage -d";
      rs-c = "rs && cg-r && cg";
      rb-c = "rb && cg-r && cg";
      up-rsc = "up && rs && cg-r && cg";
      up-rbc = "up && rb && cg-r && cg";
      cd = "z";
    };

    initContent = ''
      PS1="[%F{green}%n@%M:%~%f]$ "
      bindkey -e
    '';
  };
}
