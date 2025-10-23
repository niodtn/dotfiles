{ config, ... }:

let
  nvidiaPkgs = config.boot.kernelPackages.nvidiaPackages.latest;
in
{
  hardware.nvidia = {
    package = nvidiaPkgs;
    open = false; # closed source drivers
    powerManagement.enable = true;
    modesetting.enable = true; # boot with nvidia modeset
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  boot.extraModulePackages = [ nvidiaPkgs ];
  boot.blacklistedKernelModules = [ "nouveau" ]; # block open source driver
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  services.xserver.videoDrivers = [ "nvidia" ];
}
