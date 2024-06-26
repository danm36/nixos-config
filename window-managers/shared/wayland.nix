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
    wev
    (sddm-chili-theme.override {
      themeConfig = {
        background = config.stylix.image;
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        blur = true;
        recursiveBlurLoops = 3;
        recursiveBlurRadius = 5;
      };
    })
  ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = systemSettings.keyboardLayout;
      variant = systemSettings.keyboardVariant;
    };
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    theme = "chili";
  };
}
