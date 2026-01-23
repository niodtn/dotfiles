{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.features.tty-autologin;
in {
  options.features.tty-autologin = {
    enable = mkEnableOption "tty-autologin feature";
  };

  config = mkIf cfg.enable {
    services.getty.autologinUser = config.username;
  };
}
