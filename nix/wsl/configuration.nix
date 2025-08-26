{ config, pkgs, ... }:

{
  imports = [
    ../common/pkgs.nix
    ./pkgs.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  users.users.nixos.home = "/home/nixos";
  programs.nix-ld.enable = true;
}
