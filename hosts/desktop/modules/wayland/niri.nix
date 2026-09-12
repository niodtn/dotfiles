{
  config,
  lib,
  ...
}: let
  cfg = config.nixos.wayland.niri;

  isSteam = config.gaming.steam;
in {
  config = lib.mkIf cfg {
    flake.aspects.wayland.nixos = {config, ...}: {
      home-manager.users.${config.host.userName} = {
        wayland.windowManager.niri.settings = lib.mkMerge [
          (lib.mkIf isSteam {
            _children = [
              {
                window-rule._children = [
                  {match._props = {app-id = "r\"steam\"";};}
                  {open-maximized = true;}
                  {open-floating = false;}
                ];
              }

              {
                window-rule._children = [
                  {match._props = {app-id = "r\"cs2\"";};}
                  {open-fullscreen = true;}
                  {open-floating = true;}
                  # {variable-refresh-rate = true;}
                  # {allow-tearing = {};}
                ];
              }
            ];
          })
        ];
      };
    };
  };
}
