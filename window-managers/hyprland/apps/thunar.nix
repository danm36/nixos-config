## A file browser GUI.
{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  home.packages = with pkgs; [
    xfce.exo
    gvfs
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.tumbler
    xfce.xfconf
  ];
}
