{
  lib,
  config,
  pkgs,
  options,
  ...
}:
with lib; let
  cfg = config.features.openssh;
  hasSettings = hasAttrByPath ["services" "openssh" "settings"] options;
in {
  options.features.openssh = {
    enable = mkEnableOption "openssh feature";
  };

  config = mkIf (cfg.enable) (
    mkMerge [
      {services.openssh.enable = true;}
      (optionalAttrs hasSettings {
        services.openssh.settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = true;
        };
      })
    ]
  );
}
