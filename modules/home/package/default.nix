{ pkgs, ... }:

{
  imports =
    [ (import ./firefox) ];
#    [ (import ./python.nix) ];



  home.packages = (with pkgs; [
    # programming
    python39
    nodejs
    nodePackages.nodemon
    yarn
    gcc
    nix-prefetch-github
    vscode
    neovim
    typescript
    rnix-lsp
    ripgrep
    cargo
    rustc


    # others
    libnotify
    dmidecode
    ranger
    ueberzug
    pamixer
    cinnamon.nemo
    pavucontrol
    wget
    unzip
    discord
    gparted
    mpv
    tty-clock
    playerctl
    qalculate-gtk
    bleachbit
    imv
    cmatrix
    cava
    git
    htop
    xdg-utils
    fzf
    ffmpeg
    mpd
    ncmpcpp

    #nur
  ]);
}
