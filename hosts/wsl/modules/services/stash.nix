{
  config,
  lib,
  ...
}: let
  cfg = config.services.stash;
in {
  options = {
    services.stash = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.services.nixos = {
      config,
      pkgs,
      ...
    }: {
      services.stash = {
        enable = true;
        username = config.host.userName;

        passwordFile = pkgs.writeText "stash-password" "test";
        jwtSecretKeyFile = pkgs.writeText "stash-jwt" "test";
        sessionStoreKeyFile = pkgs.writeText "stash-session" "test";

        settings.port = 9998;
      };
    };
  };
}
