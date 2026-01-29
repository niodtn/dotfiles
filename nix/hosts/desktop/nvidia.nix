{config, ...}: let
  nvidiaPkgs = config.boot.kernelPackages.nvidiaPackages.latest;
in {
  boot = {
    extraModulePackages = [nvidiaPkgs];
    blacklistedKernelModules = ["nouveau"]; # block open source driver
    kernelParams = ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"];
  };

  hardware = {
    nvidia = {
      package = nvidiaPkgs;
      open = false; # closed source drivers
      powerManagement.enable = true;
      modesetting.enable = true; # boot with nvidia modeset
    };

    graphics.enable = true;
    graphics.enable32Bit = true;
  };

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  services.xserver.videoDrivers = ["nvidia"];
}
