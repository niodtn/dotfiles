{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.features.plymouth;
in {
  options.features.plymouth = {
    enable = mkEnableOption "plymouth feature";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelParams = ["quiet" "splash"];
      plymouth.enable = true;
      plymouth.theme = "spinner";
    };
  };
}
