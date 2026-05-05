{
  lib,
  pkgs,
  flake,
  ...
}: {
  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#utm";
  };

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # for cursor bug
  };
}
