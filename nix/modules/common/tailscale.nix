{
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.features.tailscale;
  hasHomebrew = hasAttrByPath ["homebrew"] options;
in {
  options.features.tailscale = {
    enable = mkEnableOption "tailscale feature";
  };

  config = mkIf cfg.enable (mkMerge [
    # nixos
    (optionalAttrs (!hasHomebrew) {
      services.tailscale = {
        enable = true;
        extraUpFlags = ["--ssh"];
      };
    })
    # darwin
    (optionalAttrs hasHomebrew {
      homebrew.casks = ["tailscale-app"];
    })
  ]);
}
