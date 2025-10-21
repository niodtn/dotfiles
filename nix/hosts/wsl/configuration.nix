{ flake, ... }:

{
  imports = [ flake.modules.wsl.default ];

  wsl.defaultUser = "nixos"; # nixos-wsl
  users.users.nixos.home = "/home/nixos"; # home-manager

  services.tailscale.enable = true;

  # environment.systemPackages = [ ];

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";
}
