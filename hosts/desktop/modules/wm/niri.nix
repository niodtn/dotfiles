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
      # XDG & Wayland
      ({pkgs, ...}: {
        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-gnome
          ];
          config.niri = {
            default = ["gnome" "gtk"];
            "org.freedesktop.impl.portal.FileChooser" = "gtk";
          };
        };

        environment = {
          sessionVariables = {
            XDG_SESSION_TYPE = "wayland";
            XDG_CURRENT_DESKTOP = "niri";
          };
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
        programs.niri = {
          enable = true;
          useNautilus = false;
        };

        home-manager.users.${config.host.userName} = {
          wayland.windowManager.niri = {
            enable = true;

            settings = lib.mkMerge [
              # Startup
              {
                _children = [
                  {spawn-at-startup._args = ["dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"];}
                  {spawn-at-startup._args = ["systemctl" "--user" "import-environment"];}
                  {spawn-at-startup._args = ["xwayland-satellite"];}
                  {spawn-at-startup._args = ["fcitx5" "-d"];}
                ];

                prefer-no-csd = {};
                hotkey-overlay.skip-at-startup = {};
                gestures.hot-corners.off = {};
              }

              # Input & Binds
              {
                input.mouse.accel-profile = "flat";

                binds = {
                  "Mod+Return".maximize-column = {};
                  "Mod+Shift+Return".fullscreen-window = {};
                  "Mod+Q".close-window = {};
                  "Mod+R".switch-preset-column-width = {};
                  "Mod+Tab".toggle-overview = {};

                  "Mod+WheelScrollUp".focus-workspace-up = {};
                  "Mod+WheelScrollDown".focus-workspace-down = {};
                  "Mod+Shift+WheelScrollUp".focus-column-left = {};
                  "Mod+Shift+WheelScrollDown".focus-column-right = {};
                };
              }

              {
                overview = {
                  zoom = 0.75;
                  workspace-shadow.off = {};
                };

                layout = {
                  gaps = 6;
                  shadow.on = {};
                  focus-ring.off = {};

                  border = {
                    width = 3;
                    active-color = "#ffffff30";
                    inactive-color = "#ffffff10";
                  };

                  # Positioning
                  center-focused-column = "on-overflow";
                  always-center-single-column = {};
                };

                _children = [
                  {
                    window-rule._children = [
                      {geometry-corner-radius = 15;}
                      {clip-to-geometry = true;}
                    ];
                  }

                  # Suppress maximize events for all windows
                  {
                    window-rule._children = [
                      {open-maximized = false;}
                      {open-fullscreen = false;}
                    ];
                  }
                ];
              }
            ];
          };
        };
      })
    ];
  };
}
