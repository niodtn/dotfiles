{
  disko.devices.disk = {
    main = {
      device = "/dev/disk/by-id/ata-QNIX_256GB_2021004000487";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "512M";
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
}
