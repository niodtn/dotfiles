{
  pkgs,
  flake,
  ...
}: {
  imports = [
    flake.homeModules.default
  ];

  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#utm";
      ll = "ls -al";
    };
  };
}
