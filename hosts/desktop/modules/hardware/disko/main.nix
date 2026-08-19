{
  lib,
  config,
  ...
}: let
  cfg = config.hardware.disko;
in {
  options = {
    hardware.disko = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    inputs.disko = true;

    flake.aspects.core.nixos = {
      disko.devices.disk = {
        main = {
          device = "/dev/disk/by-id/ata-QNIX_256GB_2021004000487";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              esp = {
                size = "3G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
