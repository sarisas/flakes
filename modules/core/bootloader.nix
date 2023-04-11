{pkgs, ...}: {
    boot = {
        cleanTmpDir = true;
        kernelPackages = pkgs.linuxPackages_xanmod_stable;
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
