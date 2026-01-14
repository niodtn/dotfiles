{
  flake,
  pkgs,
  ...
}: let
  username = "niodtn";
in {
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

  services.tailscale.enable = true;
  services.tailscale.extraSetFlags = ["--ssh"];

  services.getty.autologinUser = username;

  networking.hostName = "nixos-desktop";
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "uinput"
    ];
  };
}
