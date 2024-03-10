{ pkgs, ... }:

{
  # Import wayland config
  imports = [ 
    ../shared/wayland.nix
  ];

  environment.systemPackages = with pkgs; [
    grimblast
    libsForQt5.kwallet
    libsForQt5.kwallet-pam
    libsForQt5.kwalletmanager
    libsForQt5.polkit-kde-agent
  ];

  # Security
  security.pam.services = {
    login = {
      enableKwallet = true;
    };
    kwallet = {
      enableKwallet = true;
    };
    ssdm = {
      enableKwallet = true;
      text = ''
        auth include login
        '';    
    };
    swaylock = {
      enableKwallet = true;
      text = ''
        auth include login
        '';    
    };
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };
}