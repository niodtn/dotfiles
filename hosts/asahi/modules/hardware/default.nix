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

    asahi.nixos = lib.mkMerge [
      # Silent U-BOOT
      {
        nixpkgs.overlays = [
          (final: prev: {
            uboot-asahi = prev.uboot-asahi.overrideAttrs (oldAttrs: {
              extraConfig = (oldAttrs.extraConfig or "") + ''
                CONFIG_SILENT_CONSOLE=y
                CONFIG_SILENT_U_BOOT_ONLY=y
                CONFIG_VIDEO_LOGO=n
              '';
              postPatch = (oldAttrs.postPatch or "") + ''
                echo "silent=1" >> board/apple/mac/mac.env

                substituteInPlace common/version.c \
                  --replace-fail "version_string[] =" 'version_string[] = ""; const char _unused_version[] ='
              '';
            });
          })
        ];
      }

      # Power off when lid is closed
      {
        services.logind.settings.Login = {
          HandleLidSwitch = "poweroff";
          HandleLidSwitchExternalPower = "poweroff";
        };
      }
    ];
  };
}
