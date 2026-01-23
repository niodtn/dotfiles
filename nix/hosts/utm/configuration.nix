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
    # common
    zsh.enable = true;
    openssh.enable = true;

    # nixos
    systemd-boot.enable = true;
    tty-autologin.enable = true;
    hyprland.enable = true;
  };

  hardware.graphics.enable = true;

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  networking.hostName = "utm";
  username = "niodtn";
  users.users.${config.username}.extraGroups = [
    "networkmanager"
    "wheel"
  ];
}
