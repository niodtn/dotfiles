let
  common = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = [pkgs.gh];

    home-manager.users.${config.host.userName}.programs = {
      git = {
        enable = true;
      };
    };
  };
in {
  flake.aspects.git = {
    nixos = common;
    darwin = common;
  };
}
