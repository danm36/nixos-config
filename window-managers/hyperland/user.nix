{ config, lib, pkgs, userSettings, ... }:

{
    wayland.windowManager.hyprland = {
        enable = true;
        plugins = [ ];
        settings = { };
    };
}