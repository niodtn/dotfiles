{
  lib,
  config,
  options,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.ghostty;
in {
  options.features.ghostty = {
    enable = mkEnableOption "ghostty feature";
  };

  config = mkIf cfg.enable (mkMerge [
    # common
    {
      home-manager.users.${config.username}.programs.ghostty = {
        enable = true;
        settings = {
          background-opacity = 0.9;
          background-blur-radius = 10;
        };
      };
    }
    # linux
    (optionalAttrs (options ? boot) {
      home-manager.users.${config.username}.programs.ghostty = {
        systemd.enable = true;
      };
    })
    # darwin
    (optionalAttrs (options ? homebrew) {
      home-manager.users.${config.username}.programs.ghostty = {
        package = pkgs.ghostty-bin;
        settings = {
          background = "000000";
          foreground = "ffffff";
          window-padding-x = 25;
          window-padding-balance = true;
          macos-titlebar-style = "tabs";
          macos-icon = "blueprint";
          macos-secure-input-indication = false;
        };
      };
    })
  ]);
}
