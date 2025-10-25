{ flake, pkgs, ... }:

let
  username = "nixos";
in
{
  imports = [
    flake.nixosModules.default
    ./hardware.nix
    ./nvidia.nix
  ];

  modules = {
    gaming.enable = false;
    tailscale.enable = true;
  };

  # environment.systemPackages = [ ];

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
