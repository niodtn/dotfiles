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
    zsh.enable = true;

    # nixos
    tty-autologin.enable = true;
    kde.enable = true;
  };

  environment.systemPackages = [
    pkgs.google-chrome
    pkgs.github-cli
  ];

  # features.tailscale.enable = true;

  username = "niodtn";
  users.users.${config.username} = {
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "uinput"
    ];
  };

  networking.hostName = "nixos-desktop";
}
