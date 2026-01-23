{
  flake,
  inputs,
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
    openssh.enable = true;

    # nixos
    tty-autologin.enable = true;
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  username = "niodtn";
  users.users.${config.username} = {
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  networking.hostName = "nixos-desktop";
}
