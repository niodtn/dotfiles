{
  lib,
  config,
  pkgs,
  options,
  ...
}:
with lib; let
  cfg = config.features.tailscale;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in {
  config = mkIf (cfg.enable && isDarwin) (
    if (hasAttr "homebrew" options) # homebrew: Only exists within nix-darwin
    then {
      homebrew.casks = ["tailscale-app"];
    }
    else {}
  );
}
