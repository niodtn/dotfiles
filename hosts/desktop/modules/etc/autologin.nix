{
  lib,
  config,
  ...
}: let
  cfg = config.etc.autoLogin;
in {
  options = {
    etc.autoLogin = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = {config, ...}: {
      services.displayManager.autoLogin = {
        enable = true;
        user = config.host.userName;
      };
    };
  };
}
