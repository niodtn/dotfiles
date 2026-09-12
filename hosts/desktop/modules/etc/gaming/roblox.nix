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
    gaming.ananicy = true;

    flake.aspects.desktop.nixos = {
      services = {
        ananicy.extraRules = [
          {
            name = "org.vinegarhq.Sober";
            type = "Game";
          }
        ];

        flatpak = {
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
  };
}
