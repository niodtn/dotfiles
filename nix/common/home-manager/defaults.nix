{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  imports = [
      ./aliases.nix
      ./atuin.nix
      ./git.nix
  ];
}
