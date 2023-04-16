{ pkgs, ... }:

{

  programs.dconf.enable = true;
  programs.nm-applet.enable = true;
  programs.seahorse.enable = true;
  programs.fish.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gtk2";
  };
}
