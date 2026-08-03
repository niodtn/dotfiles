{
  lib,
  config,
  ...
}: {
  options = {
    etc.noctalia = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.etc.noctalia {
    inputs = {
      home-manager = true;
      noctalia = true;
    };

    flake.aspects.desktop.nixos = lib.mkMerge [
      # Greeter
      {
        # programs.noctalia-greeter = {
        #   enable = true;
        #   greeter-args = "Niri";
        # };

        # users.users.greeter.extraGroups = ["video" "render" "input"];
      }

      # Noctalia
      ({config, ...}: {
        programs.noctalia = {
          enable = true;
          systemd.enable = true;
        };

        home-manager.users.${config.host.userName} = {
          programs.noctalia = {
            enable = true;
          };
        };
      })

      # Niri
      (lib.mkIf config.wm.niri ({config, ...}: {
        # programs.noctalia-greeter.settings = {
        #   session.default = "Niri";

        #   appearance = {
        #     scheme = "Synced";
        #     password_style = "default";
        #     palette = {
        #       primary = "#fff59b";
        #       on_primary = "#0e0e43";
        #       surface = "#1a1a1a";
        #       on_surface = "#ffffff";
        #       surface_container = "#2a2a2a";
        #       error = "#ff5555";
        #     };
        #   };

        #   cursor = {
        #     theme = "Adwaita";
        #     size = 24;
        #   };

        #   keyboard = {
        #     layout = "us";
        #   };
        # };

        home-manager.users.${config.host.userName} = {
          wayland.windowManager.niri = {
            settings = lib.mkMerge [
              # Startup
              {
                _children = [{spawn-at-startup._args = ["noctalia"];}];

                # Allows notification actions and window activation from Noctalia
                debug.honor-xdg-activation-with-invalid-serial = {};
              }

              # Binds
              {
                binds = {
                  "Mod+Space".spawn-sh = "noctalia msg panel-toggle launcher";
                };
              }

              {
                _children = [
                  {
                    window-rule._children = [
                      {match._props = {app-id = "dev.noctalia.Noctalia";};}
                      {open-floating = true;}
                      {default-column-width.fixed = 1080;}
                      {default-window-height.fixed = 920;}
                    ];
                  }

                  {
                    layer-rule._children = [
                      {match._props = {namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";};}
                      {background-effect.xray = false;}
                    ];
                  }
                ];
              }

              {
                layout.background-color = "transparent";

                _children = [
                  {
                    layer-rule._children = [
                      {match._props = {namespace = "^noctalia-wallpaper";};}
                      {place-within-backdrop = true;}
                    ];
                  }
                ];
              }
            ];
          };
        };
      }))
    ];
  };
}
