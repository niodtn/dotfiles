{
  lib,
  config,
  ...
}: let
  cfg = config.gaming.ananicy;
in {
  options = {
    gaming.ananicy = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.desktop.nixos = {pkgs, ...}: {
      services.ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-rules-cachyos;
      };
    };
  };
}
