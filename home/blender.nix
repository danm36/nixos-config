{ config, pkgs, userSettings, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      blender = prev.blender.overrideAttrs (old: {
        version = "3.6.9";
      });
    })
  ];

  home.packages =  with pkgs; [ blender ];
}