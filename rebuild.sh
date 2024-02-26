#!/usr/bin/env bash
set -e

echo "NixOS config diff"
git diff -U0 *.nix

echo ""
echo "NixOS Rebuilding in '$(pwd)'..."
sudo nixos-rebuild switch --impure --flake "path:$(pwd)#default" &>nixos-switch.log || (cat nixos-switch.log | grep --color error && false)

current=$(nixos-rebuild list-generations | grep current)
git commit -am "$current"
notify-send -e "NixOS rebuild complete!" --icon=software-update-available
echo "NixOS rebuild complete!"
