{lib, ...}:
with lib; let
  cfg = config.features.vesktop;
in {
  config = {
    programs.vesktop.enable = true
  };
}
