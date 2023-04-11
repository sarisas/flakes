{ config, pkgs, lib, inputs, user, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.twemoji-color-font
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk
    pkgs.noto-fonts-emoji
    pkgs.nerdfonts
  ];
  home.file.".local/share/fonts/CartographCF-RegularItalic.ttf".source = ./CartographCF-RegularItalic.ttf;
  gtk = {
    enable = true;
    font = {
      name = "Cartograph CF";
      size = 10.5;
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      name = "Catppuccin-Macchiato-Compact-Red-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "red" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
    cursorTheme = {
      name = "Catppuccin-Frappe-Dark";
    };
  };
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors;
    name = "Catppuccin-Frappe-Red";
    size = 16;
  };
}
