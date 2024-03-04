{ pkgs, systemSettings, userSettings, ... }:

{
  imports = [ 
    ./pipewire.nix
    ./dbus.nix
    #./gnome-keyring.nix
    ./fonts.nix
  ];

  # Configure X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = systemSettings.keyboardLayout;
      variant = systemSettings.keyboardVariant;
    };
    excludePackages = [ pkgs.xterm ];
    displayManager = {
      #lightdm.enable = true;
      # Enable automatic login for the user.
      autoLogin = {
        enable = true;
        user = userSettings.username;
      };
      # sessionCommands = ''
      #     xset -dpms
      #     xset s blank
      #     xset r rate 350 50
      #     xset s 300
      #     ${pkgs.lightlocker}/bin/light-locker --idle-hint &
      # '';
    };
    libinput = {
      touchpad.disableWhileTyping = true;
    };
  };
}
