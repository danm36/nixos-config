## A battery manager service that uses libnotify when
## the battery crosses certain thresholds.
{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  wayland.windowManager.hyprland.settings.exec-once = [
    "batsignal"
  ];
}
