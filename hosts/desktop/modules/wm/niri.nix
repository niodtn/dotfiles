{
  lib,
  config,
  ...
}: {
  options = {
    wm.niri = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.wm.niri {
    inputs.home-manager = true;

    wm.wayland = true;

    etc = {
      fonts = true;
      fcitx5 = true;
      network = true;
      sound = true;
    };

    flake.aspects.host-desktop.nixos = {config, ...}:
      lib.mkMerge [
        # Wayland
        {
          environment = {
            XDG_SESSION_TYPE = "wayland";
            pathsToLink = ["/share/wayland-sessions"];
          };
        }

        # Greetd
        {
          services.greetd = {
            enable = true;
            settings.default_session = {
              command = "dbus-run-session ${config.programs.niri.package}/bin/niri";
              user = "niodtn";
            };
          };

          systemd.user.services.niri.enableDefaultPath = false;
        }

        # Niri
        {
          home-manager.users.${config.host.userName} = {
            wayland.windowManager.niri = {
              enable = true;

              settings = {
                prefer-no-csd = {};
              };
            };
          };
        }
      ];
  };
}
