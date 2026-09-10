{
  lib,
  config,
  ...
}: let
  cfg = config.gaming.games.roblox;
in {
  options = {
    gaming.games.roblox = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    inputs.nix-flatpak = true;

    gaming = {
      gamemode = true;
      gamescope = true;
    };

    flake.aspects.desktop.nixos = {
      services.flatpak = {
        packages = ["org.vinegarhq.Sober"];

        overrides.settings = {
          "org.vinegarhq.Sober" = {
            Context = {
              sockets = ["!wayland" "x11"];
              devices = ["all"];
            };
            Environment = {
              WAYLAND_DISPLAY = "";
            };
          };
        };
      };
    };
  };
}
