{...}:

{
    security.rtkit.enable = true;
    security.sudo.enable = false;
    security.doas.enable = true;
    security.pam.services.swaylock = { };
    security.doas.extraRules = [{
      keepEnv = true;
      persist = true;
    }];
}