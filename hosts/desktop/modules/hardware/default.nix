{lib, ...}: {
  flake.aspects.core.nixos = lib.mkMerge [
    {
      boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      hardware.enableAllFirmware = true;
    }

    {
      zramSwap.enable = true;
      powerManagement.cpuFreqGovernor = "performance";

      services = {
        power-profiles-daemon.enable = false;
        tlp.enable = false;
      };
    }
  ];
}
