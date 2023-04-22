{ pkgs, inputs, ... }:

let
  name = "sarisas";
  username = "sarisas";
  email = "1842391001@qq.com";
  initialHashedPassword = "$6$8DFWmGTnwWNDAkbY$GWxMQ24bt8I2O75HhY31MOZXnMunmRK7jBahqpE95X4n9coTTGsJEK3wllU8l3Pm5AT3m8z2//l4723S4qYyo/";
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
       home.stateVersion = "23.05";
       programs.home-manager.enable = true;
       programs.git.enable = true;
       programs.git.userName = name;
       programs.git.userEmail = email;
     };
   };

  users.users.${username} = {
    isNormalUser = true;
    initialHashedPassword = initialHashedPassword;
    description = name;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };
  security.doas.extraRules = [{
    users = [ "sarisas" ];
  }];
  # users.users.root.initialHashedPassword = initialHashedPassword;
  services.getty.autologinUser = "sarisas";
  nix.settings.allowed-users = [ "sarisas" ];
}
