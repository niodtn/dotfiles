{config, ...}: {
  boot = {
    blacklistedKernelModules = ["nouveau"]; # block open source driver
    kernelParams = ["nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" "initcall_blacklist=simpledrm_platform_driver_init"];
    initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  };

  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      open = false; # closed source drivers
      powerManagement.enable = false;
      modesetting.enable = true; # boot with nvidia modeset
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  services.xserver.videoDrivers = ["nvidia"];
}
