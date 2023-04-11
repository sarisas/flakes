{
  description = "Fahim's nixos configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, self, ... }@inputs:
    let
      selfPkgs = import ./pkgs;
    in
    {
      overlays.default = selfPkgs.overlay;
      nixosConfigurations = (import ./modules/core/default.nix {
        inherit self nixpkgs inputs;
      });
    };
}
