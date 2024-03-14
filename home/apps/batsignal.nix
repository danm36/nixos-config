## A battery manager service that uses libnotify when
## the battery crosses certain thresholds.

{ config, pkgs, userSettings, ... }:

{
  home.file.".config/batsignal".text = ''
    # Run in background.
    -b

    # Warning at 20%.
    -w
    20
    -W
    Battery is at 20%.

    # Critical at 10%.
    -c
    10
    -C
    Battery is at 10%.

    # Danger at 5%.
    -d
    5

    # Show a message when battery starts charging or discharging.
    -p
    -P
    Battery is charging.
    -U
    Battery is discharging.
    '';
}
