{ ... }:

{
  imports = [ 
        ../shared/x11.nix
    ];

    # Enable the KDE Plasma Desktop Environment.
    services.xserver = {
        desktopManager = {
            plasma5.enable = true;
        };
    };
}