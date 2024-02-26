{ config, lib, ... }:
{
  # Nvidia setup
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:3:0:0";
    };

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # Add Nvidia XServer drivers
  services.xserver.videoDrivers = [ "nvidia" ];
}
