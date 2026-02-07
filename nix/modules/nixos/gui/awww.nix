{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  guiEnabled = config.features.gui.enable;
  cfg = config.features.gui.awww;
in {
  options.features.gui.awww = {
    enable = mkEnableOption "awww feature";
  };

  config = mkIf (guiEnabled && cfg.enable) {
    environment.systemPackages = [
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ];

    # niri
    programs.niri.settings = mkIf config.features.gui.niri.enable {
      spawn-at-startup = [
        {command = ["awww"];}
      ];
    };
  };
}
