{
  lib,
  config,
  ...
}: let
  cfg = config.hardware.disko;
in {
  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = {config, ...}: {
      systemd.tmpfiles.rules = ["d /mnt/hdd2 0755 ${config.host.userName} users -"];

      disko.devices.disk = {
        hdd2 = {
          device = "/dev/disk/by-id/wwn-0x5000c5008a720b2f";
          content = {
            type = "gpt";
            partitions = {
              data = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/mnt/hdd2";
                };
              };
            };
          };
        };
      };
    };
  };
}
