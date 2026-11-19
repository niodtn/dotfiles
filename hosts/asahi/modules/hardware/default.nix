{lib, ...}: {
  flake.aspects = {
    core.nixos = lib.mkMerge [
      {
        boot = {
          loader.systemd-boot.enable = true;
          loader.efi.canTouchEfiVariables = false;
          initrd.availableKernelModules = ["usb_storage"];
        };
        hardware.asahi.enable = true;
      }

      # Mount
      {
        fileSystems = {
          "/" = {
            device = "/dev/disk/by-uuid/8f0e2c4d-ca4e-4f89-b543-952ec18ec7b0";
            fsType = "ext4";
          };
          "/boot" = {
            device = "/dev/disk/by-uuid/369B-1DFA";
            fsType = "vfat";
            options = [ "fmask=0022" "dmask=0022" ];
          };
        };
      }

      # WIFI
      {
        networking.wireless.iwd = {
          enable = true;
          settings.Settings.AutoConnect = true;
        };
      }
    ];
  };
}
