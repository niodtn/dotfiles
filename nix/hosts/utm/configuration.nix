{
  flake,
  pkgs,
  config,
  ...
}: {
  imports = [
    flake.nixosModules.default
    ./hardware.nix
  ];

  features = {
    zsh.enable = true;
  };

  fileSystems."/home/niodtn/dotfiles" = {
    device = "share";
    fsType = "9p";
    options = ["trans=virtio" "version=9p2000.L" "rw" "user" "dmask=0777,fmask=0777"];
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "virtio_input"
    "virtio_gpu"
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  username = "niodtn";
  users.users.${config.username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  services.getty.autologinUser = config.username;

  networking.hostName = "nixos-desktop";
}
