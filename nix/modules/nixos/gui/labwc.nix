{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  guiEnabled = config.features.gui.enable;
  cfg = config.features.gui.labwc;
in {
  options.features.gui.labwc = {
    enable = mkEnableOption "labwc feature";
  };

  config = mkIf (guiEnabled && cfg.enable) {
    programs.labwc.enable = true;

    environment.variables = {
      XDG_CURRENT_DESKTOP = "labwc";
      XDG_SESSION_TYPE = "wayland";
    };

    environment.systemPackages = with pkgs; [
      waybar
      sfwbar
      foot
    ];

    home-manager.users.${config.username} = {
      wayland.windowManager.labwc = {
        enable = true;
        rc = {
          keyboard = {
            default = true;
            keybind = [
              {
                "@key" = "W-Return";
                action = {
                  "@name" = "Execute";
                  "@command" = "foot";
                };
              }
            ];
          };
        };
      };

      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 20;
      };
    };
  };
}
