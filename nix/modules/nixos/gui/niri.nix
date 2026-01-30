{
  lib,
  config,
  pkgs,
  flake,
  ...
}:
with lib; let
  guiEnabled = config.features.gui.enable;
  cfg = config.features.gui.niri;
in {
  options.features.gui.niri = {
    enable = mkEnableOption "niri feature";
  };

  config = mkIf (guiEnabled && cfg.enable) {
    environment.systemPackages = [pkgs.xwayland-satellite];
    xdg.portal.config.niri.default = ["gnome" "gtk"];

    programs.niri = {
      enable = true;
    };

    # Home Manager Options
    home-manager.users.${config.username} = {
      home.file.".config/niri".source = "${flake}/niri";

      home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 20;
      };

      services.walker = {
        enable = true;
        settings = {
          close_when_open = false;
          click_to_close = true;
        };
      };
    };
  };
}
