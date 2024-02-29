{ config, pkgs, userSettings, systemSettings, ... }:

{
  # Set your time zone.
  time.timeZone = systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  fonts.fontDir.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    "${userSettings.username}" = {
      isNormalUser = true;
      description = userSettings.name;
      extraGroups = [ "networkmanager" "wheel" ];
      uid = 1000;
    };
  };

  # Configure console keymap
  console.keyMap = systemSettings.keyMap;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    libnotify
    libxcrypt
    lshw
    wget
    curl
    git
    git-lfs
    git-credential-manager
    home-manager
    nano
    vim
    neofetch
    nodejs_20
    corepack_20
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libz
    libxcrypt
    libarchive
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages.
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
