{
  config,
  lib,
  ...
}: let
  cfg = config.programs.fish;
in {
  options.programs.fish = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg {
    inputs.home-manager = true;

    flake.aspects.programs = {
      homeManager = {
        programs.fish = {
          enable = true;

          interactiveShellInit = ''
            set -g fish_greeting ""
          '';
        };
      };

      nixos = {
        config,
        pkgs,
        ...
      }: {
        programs.fish.enable = true;
        users.users.${config.host.userName}.shell = pkgs.fish;
      };

      darwin = {
        config,
        pkgs,
        ...
      }: {
        programs.fish.enable = true;
        users.users.${config.host.userName}.shell = pkgs.fish;

        environment.shells = [pkgs.fish];
      };
    };
  };
}
