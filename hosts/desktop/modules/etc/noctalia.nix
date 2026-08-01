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

    flake.aspects.host-desktop.nixos = lib.mkMerge [
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
        home-manager.users.${config.host.userName} = {
          wayland.windowManager.niri = {
            settings = {
              binds = {
                "Mod+Space".spawn-sh = "noctalia msg panel-toggle launcher";
              };

              layout.background-color = "transparent";
              overview.workspace-shadow.off = {};

              _children = [
                {spawn-at-startup._args = ["noctalia"];}

                {
                  window-rule._children = [
                    {geometry-corner-radius = 20;}
                    {clip-to-geometry = true;}
                  ];
                }

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
                    {match._props = {namespace = "^noctalia-wallpaper";};}
                    {place-within-backdrop = true;}
                  ];
                }
              ];

              debug = {
                honor-xdg-activation-with-invalid-serial = {};
              };
            };
          };
        };
      }))
    ];
  };
}
