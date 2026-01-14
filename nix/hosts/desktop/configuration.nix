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

  modules = {
    gaming.enable = false;
  };

  # environment.systemPackages = [ ];

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
