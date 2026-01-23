{
  flake,
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    flake.nixosModules.default
    inputs.vscode-server.nixosModules.default
    ./hardware.nix
  ];

  features = {
    zsh.enable = true;
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
  services.vscode-server.enable = true;

  boot.initrd.availableKernelModules = [
    "virtio_pci"
    "virtio_blk"
    "virtio_input"
    "virtio_gpu"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
