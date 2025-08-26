{ config, pkgs, ... }:

{
  imports = [
    ../common/pkgs.nix
    ./pkgs.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  programs.nix-ld.enable = true;
}
