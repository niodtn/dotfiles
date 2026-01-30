{
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.features.tailscale;
in {
  options.features.tailscale = {
    enable = mkEnableOption "tailscale feature";
  };

  config = mkIf cfg.enable (mkMerge [
    # linux
    (optionalAttrs (options ? boot) {
      services.tailscale = {
        enable = true;
        extraUpFlags = ["--ssh"];
      };
    })
  ]);
}
