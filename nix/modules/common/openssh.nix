{
  lib,
  config,
  pkgs,
  options,
  ...
}:
with lib; let
  cfg = config.features.openssh;
  hasHomebrew = hasAttrByPath ["homebrew"] options;
in {
  options.features.openssh = {
    enable = mkEnableOption "openssh feature";
  };

  config = mkIf (cfg.enable) (mkMerge [
    # nixos
    (optionalAttrs (!hasHomebrew) {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = true;
        };
      };
    })
    # darwin
    (optionalAttrs hasHomebrew {})
  ]);
}
