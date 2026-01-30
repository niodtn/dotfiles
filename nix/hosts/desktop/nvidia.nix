{config, ...}: let
  nvidiaPkgs = config.boot.kernelPackages.nvidiaPackages.stable;
in {
  boot = {
    extraModulePackages = [nvidiaPkgs];
    blacklistedKernelModules = ["nouveau"]; # block open source driver
    kernelParams = ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"];
    initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  };

  hardware = {
    nvidia = {
      package = nvidiaPkgs;
      open = false; # closed source drivers
      powerManagement.enable = false;
      modesetting.enable = true; # boot with nvidia modeset
      # nvidiaSettings = true;
    };

    graphics.enable = true;
    graphics.enable32Bit = true;
  };

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  services.xserver.videoDrivers = ["nvidia"];
}
