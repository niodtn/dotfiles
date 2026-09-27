{
  config,
  lib,
  ...
}: let
  cfg = config.programs.git;

  name = "niodtn";
  email = "ipegte93@gmail.com";
in {
  options.programs.git = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg {
    inputs.home-manager = true;

    flake.aspects.programs = {
      homeManager.programs = {
        direnv = {
          enable = true;
          silent = true;
          nix-direnv.enable = true;
        };

        git = {
          enable = true;
          settings.user = {inherit name email;};
        };

        programs.gh = {
          enable = true;
        };

        jujutsu = {
          enable = true;
          settings = {
            user = {inherit name email;};
            ui.default-commnad = "log";
            revset-aliases."immutable_heads()" = "trunk() | tags()";
          };
        };

        jjui = {
          enable = true;
        };
      };
    };
  };
}
