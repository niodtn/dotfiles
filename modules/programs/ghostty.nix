{
  config,
  lib,
  ...
}: let
  cfg = config.programs.ghostty;
in {
  options.programs.ghostty = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = lib.mkIf cfg {
    inputs.home-manager = true;

    flake.aspects.programs = {
      homeManager = {
        programs.ghostty = {
          enable = true;
        };
      };

      nixos = {config, ...}: {
        home-manager.users.${config.host.userName} = {
          programs.ghostty = {
            systemd.enable = true;
          };
        };
      };

      darwin = {
        config,
        pkgs,
        ...
      }: {
        home-manager.users.${config.host.userName} = {
          programs.ghostty = {
            package = pkgs.ghostty-bin;
            settings = {
              macos-titlebar-style = "tabs";
              macos-option-as-alt = true;
              macos-icon = "blueprint";
              macos-secure-input-indication = false;

              background = "000000";
              foreground = "ffffff";
              window-padding-x = 25;
              window-padding-balance = true;
            };
          };
        };
      };
    };
  };
}
