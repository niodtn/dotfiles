{
  lib,
  config,
  ...
}: {
  imports = [
    ./disko.nix
    ./it8613e.nix
    ./nvidia.nix
  ];

  config = lib.mkMerge [
    {
      boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      boot.kernelModules = ["kvm-amd"];

      hardware = {
        enableAllFirmware = true;
        cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
      };
    }

    # Bluetooth
    {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General.Experimental = true;
      };
    }

    # Bluetooth - Airpods
    {
      services.pipewire.wireplumber.enable = true;

      programs.librepods.enable = true;
      users.users.${config.host.userName}.extraGroups = ["librepods"];
    }
  ];
}
