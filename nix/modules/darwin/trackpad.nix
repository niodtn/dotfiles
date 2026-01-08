{ lib, config, ... }:
with lib;

let
  cfg = config.features.trackpad;

in
{
  options.features.trackpad = {
    enable = mkEnableOption "trackpad feature";
  };

  config = mkIf cfg.enable {
    # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
    system.defaults.trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
      ActuationStrength = 0;
      FirstClickThreshold = 0;
      SecondClickThreshold = 0;
    };
  };
}
