{
  lib,
  config,
  pkgs,
  ...
}:
with lib; {
  options.features.tailscale.enable = mkEnableOption "tailscale feature";

  imports = [
    ./linux.nix
    ./darwin.nix
  ];
}
