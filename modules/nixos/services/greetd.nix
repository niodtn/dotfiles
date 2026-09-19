{
  config,
  lib,
  ...
}: let
  cfg = config.nixos.services.greetd;

  isNiri = config.nixos.wayland.niri;
in {
  options = {
    nixos.services.greetd = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.services.nixos = lib.mkMerge [
      ({config, ...}: {
        services.greetd = {
          enable = true;
          settings.default_session = {
            user = config.host.userName;
          };
        };
      })

      (lib.mkIf isNiri ({config, ...}: {
        services.greetd.settings.default_session.command = "dbus-run-session ${config.programs.niri.package}/bin/niri";
        systemd.user.services.niri.enableDefaultPath = false;
      }))
    ];
  };
}
