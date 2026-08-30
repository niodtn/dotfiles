{
  flake.aspects.core.nixos = {
    boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    hardware.enableAllFirmware = true;
    zramSwap.enable = true;
  };
}
