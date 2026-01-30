{
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.features.openssh;
in {
  options.features.openssh = {
    enable = mkEnableOption "openssh feature";
  };

  config = mkIf (cfg.enable) (mkMerge [
    # linux
    (optionalAttrs (options ? boot) {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = true;
        };
      };
    })
    # darwin
    (optionalAttrs (options ? homebrew) {})
  ]);
}
