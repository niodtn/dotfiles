{
  lib,
  pkgs,
  flake,
  ...
}: {
  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#utm";
      ll = "ls -al";
    };
  };
}
