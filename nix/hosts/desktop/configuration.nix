{
  flake,
  pkgs,
  config,
  ...
}: {
  imports = [
    flake.nixosModules.default
    ./hardware.nix
    ./nvidia.nix
  ];

  features = {
    # common
    zsh.enable = true;
    # tailscale.enable = true;

    # nixos
    systemd-boot.enable = true;
    plymouth.enable = true;
    sound.enable = true;
    tty-autologin.enable = true;
    bluetooth.enable = true;
    kde.enable = true;
  };

  environment.systemPackages = [
    pkgs.google-chrome
    pkgs.github-cli
  ];

  username = "niodtn";
  users.users.${config.username}.extraGroups = [
    "networkmanager"
    "wheel"
    "video"
    "input"
    "uinput"
  ];
}
