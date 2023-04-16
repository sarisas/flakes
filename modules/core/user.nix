{ pkgs, inputs, ... }:

let
  name = "Samiul Basir Fahim";
  username = "fahim";
  email = "samiulbasirfahim360@gmail.com";
  initialPassword = "dreamX";
  packages = with pkgs;[
    fish
  ];
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
   home-manager = {
     useUserPackages = true;
     useGlobalPkgs = true;
     extraSpecialArgs = { inherit inputs; };
     users.${username} = {
       imports = [ (import ./../home) ];
       home.username = username;
       home.homeDirectory = "/home/${username}";
       home.stateVersion = "22.11";
       programs.home-manager.enable = true;
       programs.git.enable = true;
       programs.git.userName = name;
       programs.git.userEmail = email;
     };
   };

  users.users.${username} = {
    isNormalUser = true;
    initialPassword = initialPassword;
    description = name;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
  security.doas.extraRules = [{
    users = [ "fahim" ];
  }];
  users.users.root.initialPassword = initialPassword;
  services.getty.autologinUser = "fahim";
  nix.settings.allowed-users = [ "fahim" ];
}
