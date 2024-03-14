{ config, pkgs, userSettings, ... }:

{
    home.packages = with pkgs; [ godot_4 ];
    home.file = {
        "Applications/Godot".source = config.lib.file.mkOutOfStoreSymlink pkgs.godot_4;
        ".config/godot/editor_settings-4.tres".source = ../../config/godot/editor_settings-4.tres;
    };
}