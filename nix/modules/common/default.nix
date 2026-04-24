{
  self,
  inputs,
  lib,
  ...
}: {
  flake.commonModules.default = {
    config,
    lib,
    pkgs,
    ...
  }: let
    username = config.username;
  in {
    options.username = lib.mkOption {
      type = lib.types.str;
      default = "niodtn";
    };

    config = {
      nixpkgs.config.allowUnfree = true;

      nix = {
        gc = {
          automatic = lib.mkDefault true;
          options = "--delete-older-than 30d";
        };

        settings = {
          experimental-features = "nix-command flakes";
          auto-optimise-store = true;
        };
      };

      # Home-Manager
      users.users.${username}.home =
        if pkgs.stdenv.hostPlatform.isLinux
        then "/home/${username}"
        else "/Users/${username}";

      home-manager = {
        backupFileExtension = "backup";
        users.${username} = {
          home.shellAliases = {
            ".." = "cd ../";
            "..." = "cd ../../";
            c = "clear";
          };

          home.stateVersion = "26.05";
        };
      };
    };
  };
}
