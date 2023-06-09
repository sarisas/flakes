{ inputs, nixpkgs, self, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  lib = nixpkgs.lib;
in
{
  nixos = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit self inputs; };
    modules =
      [ (import ./bootloader.nix) ] ++
      [ (import ./hardware.nix) ] ++
      [ (import ./network.nix) ] ++
      [ (import ./pipewire.nix) ] ++
      [ (import ./program.nix) ] ++
      [ (import ./../home/package/python.nix) ] ++
      [ (import ./security.nix) ] ++
      [ (import ./services.nix) ] ++
      [ (import ./system.nix) ] ++
      [ (import ./user.nix) ] ++
      [ (import ./wayland.nix) ] ++ 
      [ (import ./../../hosts/nixos/hardware-configuration.nix) ];
  };
}
