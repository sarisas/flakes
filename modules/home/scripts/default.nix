{ pkgs, ... }:


let
  wall-change = pkgs.writeShellScriptBin "wall-change" ''
    swww img $1 --transition-type random --transition-pos "$(hyprctl cursorpos)" --transition-duration 3
  '';
in
{
  home.file.".local/bin/toggle_sound_output".source = ./toggle_sound_output;
  home.file.".local/bin/toggle_hyprland_layout".source = ./toggle_hyprland_layout;
  home.file.".local/bin/wallpaper_picker".source = ./wallpaper_picker;
  home.file.".local/bin/toggle_opacity".source = ./toggle_opacity;
  home.file.".local/bin/toggle_blur".source = ./toggle_blur;
  home.file.".local/bin/toggle_animation".source = ./toggle_animtion;
  home.file.".local/bin/anime".source = ./ani-cli;
  home.file.".local/bin/git-push".source = ./git-push.sh;
  home.file.".local/bin/env/load_env".source = ./load_env;
  home.packages = with pkgs; [
    wall-change
  ];
}
