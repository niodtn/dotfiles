{
  lib,
  pkgs,
  flake,
  ...
}: {
  imports = [
    flake.homeModules.default
  ];

  features = {
    atuin.enable = lib.mkForce false;
  };

  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#utm";
      ll = "ls -al";
    };
  };
}
