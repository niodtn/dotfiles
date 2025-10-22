{ config, ... }:

let
  nvidiaPkgs = config.boot.kernelPackages.nvidiaPackages.latest;
in
{
  # Nvidia settings
  hardware.graphics.enable32Bit = true;
  hardware.nvidia.package = nvidiaPkgs;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.extraModulePackages = [ nvidiaPkgs ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
