let
  common = {config, ...}: {
    home-manager.users.${config.host.userName}.programs = {
      git = {
        enable = true;
      };
    };
  };
in {
  flake.aspects = {aspects, ...}: {
    git = {
      includes = with aspects; [gh];
      nixos = common;
      darwin = common;
    };
  };
}
