{ pkgs, inputs, ... }:


{
  imports = [
    inputs.hyprland.nixosModules.default
  ];
  programs.hyprland.enable = true;
  programs.waybar.enable = true;
  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
  });
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
