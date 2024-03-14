{ config, pkgs, userSettings, ... }:

{
    home.packages =  with pkgs; [ blender ];
    home.file = {
        "Applications/Blender".source = config.lib.file.mkOutOfStoreSymlink pkgs.blender;
    };
}
