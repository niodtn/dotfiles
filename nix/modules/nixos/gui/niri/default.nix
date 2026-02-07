{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  guiEnabled = config.features.gui.enable;
  cfg = config.features.gui.niri;
in {
  options.features.gui.niri = {
    enable = mkEnableOption "niri feature";
  };

  imports = [
    inputs.niri.nixosModules.niri
    ./walker.nix
  ];

  config = mkIf (guiEnabled && cfg.enable) {
    environment.systemPackages = [pkgs.xwayland-satellite];
    xdg.portal.config.niri.default = ["gnome" "gtk"];

    # nixpkgs.overlays = [inputs.niri.overlays.niri];

    programs.niri = {
      enable = true;
      # package = pkgs.niri-unstable;
      package = pkgs.niri;
    };

    # systemd.user.services.niri-flake-polkit.enable = false;

    # Home Manager Options
    home-manager.users.${config.username} = {
      programs.niri = {
        settings = {
          input.mouse.accel-profile = "flat";
          hotkey-overlay.skip-at-startup = true;
          prefer-no-csd = true; # Hide Title Bar

          binds = {
            "Mod+Q".action.close-window = [];
            "Mod+W".action.toggle-column-tabbed-display = [];

            "Mod+Return".action.maximize-column = [];
            "Mod+Shift+Return".action.fullscreen-window = [];
            "Mod+R".action.reset-window-instance-size = [];

            "Mod+Left".action.focus-column-left = [];
            "Mod+Right".action.focus-column-right = [];
            "Mod+Shift+Left".action.focus-column-first = [];
            "Mod+Shift+Right".action.focus-column-last = [];

            # "Print".action.screenshot = [];
            # "Ctrl+Print".action.screenshot-screen = [];
            # "Alt+Print".action.screenshot-window = [];
          };

          window-rules = [
            {
              geometry-corner-radius = {
                bottom-left = 12.0;
                bottom-right = 12.0;
                top-left = 12.0;
                top-right = 12.0;
              };
              clip-to-geometry = true;
            }
          ];

          spawn-at-startup = [
            {command = ["dbus-update-activation-environment" "--all"];}
          ];
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
