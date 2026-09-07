{
  lib,
  config,
  ...
}: let
  cfg = config.hardware.disko;
in {
  config = lib.mkIf cfg {
    flake.aspects.desktop.nixos = {config, ...}: {
      systemd.tmpfiles.rules = ["d /mnt/hdd1 0755 ${config.host.userName} users -"];

      disko.devices.disk = {
        hdd1 = {
          device = "/dev/disk/by-id/wwn-0x5000c500663551da";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              data = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/mnt/hdd1";
                };
              };
            };
          };
        };
      };
    };
  };
}
