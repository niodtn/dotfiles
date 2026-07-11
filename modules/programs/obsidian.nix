{...}: let
  common = {
    config,
    pkgs,
    ...
  }: {
    home-manager.users.${config.host.userName} = {
      home.packages = [pkgs.obsidian];
    };
  };
in {
  flake.aspects.obsidian = {
    nixos = common;
    darwin = common;
  };
}
