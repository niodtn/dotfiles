{
  lib,
  config,
  pkgs,
  options,
  ...
}:
with lib; let
  cfg = config.features.tailscale;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in {
  config = mkIf (cfg.enable && isLinux) (
    if (hasAttrByPath ["services" "tailscale" "extraSetFlags"] options) # services.tailscale.extraSetFlags: Only exists within NixOS
    then {
      services.tailscale = {
        enable = true;
        extraSetFlags = ["--ssh"];
      };
    }
    else {}
  );
}
