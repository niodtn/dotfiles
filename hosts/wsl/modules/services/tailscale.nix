{
  config,
  lib,
  ...
}: let
  cfg = config.services.tailscale;
in {
  config = lib.mkIf cfg {
    flake.aspects.core.nixos = {
      networking.firewall = {
        enable = true;
        checkReversePath = "loose";
      };
    };
  };
}
