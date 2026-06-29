{config, ...}: {
  imports = [
    ./disko.nix
    ./it8613e.nix
    ./nvidia.nix
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.kernelModules = ["kvm-amd"];
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

  services = {
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
    };

    xserver.xkb = {
      layout = "us,kr";
      options = "caps:ctrl_modifier";
    };
  };
}
