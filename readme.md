<div align="center">

# **Nixos - Hyprland**
</div>

## Installation guide

1. ``` git clone https://github.com/sarisas/flakes.git ~/Flakes ```
2. ``` cd ~/Flakes ```
3. ``` rm -rf .git/ && rm -rf hosts/nixos/hardware-configuration.nix```
4. ``` cp -r /etc/nixos/hardware-configuration.nix  hosts/nixos/ ```
5. ``` sudo nixos-rebuild switch --flake ~/Flakes/.#nixos ```
