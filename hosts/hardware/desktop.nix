 { config, pkgs, userSettings, ... }:

{
  imports = [
    ./common.nix
    ./bluetooth.nix
    ./opengl.nix
    (./. + "../../../window-managers" + ("/" + userSettings.windowManager) + "/system.nix")
    ../../themes/system.nix
  ];

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    batsignal
  ];
}
