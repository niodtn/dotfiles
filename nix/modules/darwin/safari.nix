{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.features.safari;
in {
  options.features.safari = {
    enable = mkEnableOption "safari feature";
  };

  config = mkIf cfg.enable {
    system.defaults.CustomSystemPreferences."com.apple.Safari" = {
      "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
    };
  };
}
