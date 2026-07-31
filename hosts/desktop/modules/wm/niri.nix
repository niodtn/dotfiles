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
    etc.fcitx5 = true;

    flake.aspects.host-desktop.nixos = lib.mkMerge [
      # Wayland
      ({pkgs, ...}: {
        environment = {
          variables.XDG_SESSION_TYPE = "wayland";
          pathsToLink = ["/share/wayland-sessions"];
          systemPackages = with pkgs; [xwayland-satellite];
        };
      })

      # Greetd
      ({config, ...}: {
        services.greetd = {
          enable = true;
          settings.default_session = {
            command = "dbus-run-session ${config.programs.niri.package}/bin/niri";
            user = "niodtn";
          };
        };

        systemd.user.services.niri.enableDefaultPath = false;
      })

      # Niri
      ({config, ...}: {
        home-manager.users.${config.host.userName} = {
          wayland.windowManager.niri = {
            enable = true;

            settings = {
              prefer-no-csd = {};
              hotkey-overlay.skip-at-startup = {};

              input.mouse.accel-profile = "flat";

              _children = [
                {spawn-at-startup._args = ["systemctl" "--user" "import-environment"];}
                {spawn-at-startup._args = ["xwayland-satellite"];}
                {spawn-at-startup._args = ["fcitx5" "-d"];}

                # Suppress maximize events for all windows
                {
                  window-rule._children = [
                    {open-maximized = false;}
                    {open-fullscreen = false;}
                  ];
                }
              ];
            };
          };
        };
      })
    ];
  };
}
