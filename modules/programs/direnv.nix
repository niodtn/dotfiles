let
  common = {config, ...}: {
    home-manager.users.${config.host.userName}.programs = {
      direnv = {
        enable = true;
        silent = true;
        nix-direnv.enable = true;
      };
    };
  };
in {
  flake.aspects.direnv = {
    nixos = common;
    darwin = common;
  };
}
