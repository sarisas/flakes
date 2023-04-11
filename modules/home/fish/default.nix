{ hostname, config, pkgs, ... }: {
  programs.fish = {
     loginShellInit = ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '';
    enable = true;
    shellAliases = {
      n = "clear && neofetch";
      v = "nvim";
      record = "wf-recorder -f $HOME/Videos/$(date +'%Y%m%d%H%M%S_1.mp4')";
      ani = "bash $HOME/.local/bin/anime --dub";

      # nixos
      ncg = "nix-collect-garbage && nix-collect-garbage -d && doas nix-collect-garbage && doas nix-collect-garbage -d && doas rm /nix/var/nix/gcroots/auto/*";
      nrf = "doas nixos-rebuild switch --flake ~/Flakes/.#nixos";
      fl = "cd ~/Flakes";

      # python
      piv = "python -m venv .venv";
      psv = "source .venv/bin/activate.fish";

      # git
      push = "bash $HOME/.local/bin/git-push";
    };
  };
}
