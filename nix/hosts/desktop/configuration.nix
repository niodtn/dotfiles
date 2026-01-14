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
    kde.enable = true;
  };

  environment.systemPackages = [
    pkgs.google-chrome
  ];

  # services.tailscale.enable = true;
  # services.tailscale.extraSetFlags = ["--ssh"];

  username = "niodtn";
  users.users.${config.username} = {
    isNormalUser = true;
    home = "/home/${config.username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "uinput"
    ];
  };

  services.getty.autologinUser = config.username;

  networking.hostName = "nixos-desktop";
}
