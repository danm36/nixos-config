{ config, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    #./gnome-keyring.nix
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs; [ 
    wayland 
    waydroid
  ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = systemSettings.keyboardLayout;
      variant = systemSettings.keyboardVariant;
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "chili";
    };
  };
}
