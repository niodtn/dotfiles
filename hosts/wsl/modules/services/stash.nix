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
    flake.aspects.services.nixos = {pkgs, ...}: {
      services.stash = {
        enable = true;
        username = "admin";

        passwordFile = pkgs.writeText "stash-password" "$2b$05$cBmu3g7htwrc7IjrgEUfzeqeeybiu50vE2PuErKC4yPCrOtfvkF.W";
        jwtSecretKeyFile = pkgs.writeText "stash-jwt" "fixed-jwt-secret-key";
        sessionStoreKeyFile = pkgs.writeText "stash-session" "fixed-session-key";

        settings.port = 9998;
      };
    };
  };
}
