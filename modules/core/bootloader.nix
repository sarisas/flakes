{ pkgs, ... }:
{
  boot = {
    cleanTmpDir = true;
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    plymouth = {
      enable = false;
    };
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
