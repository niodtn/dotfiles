{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.features.sound;
in {
  options.features.sound = {
    enable = mkEnableOption "sound feature";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
