{
  lib,
  config,
  pkgs,
  flake,
  ...
}:
with lib; let
  username = config.username;
in {
  imports = [
    ./vscode
    ./atuin.nix
    ./comma.nix
    ./direnv.nix
    ./ghostty.nix
    ./git.nix
    ./jujutsu.nix
    ./openssh.nix
    ./python.nix
    ./sshfs.nix
    ./starship.nix
    ./tailscale.nix
    ./vesktop.nix
    ./zen-browser.nix
    ./zsh.nix
  ];

  options.username = mkOption {
    type = types.str;
  };

  config = {
    system.stateVersion = mkDefault "26.05";

    users.users.${username}.home =
      if pkgs.stdenv.hostPlatform.isLinux
      then "/home/${username}"
      else "/Users/${username}";

    nixpkgs = {
      hostPlatform = mkDefault "x86_64-linux";
      config.allowUnfree = true;
    };

    nix = {
      gc = {
        automatic = mkDefault true;
        options = "--delete-older-than 30d";
      };

      settings = {
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;

        extra-substituters = flake.lib.caches.substituters;
        extra-trusted-public-keys = flake.lib.caches.trustedPublicKeys;
      };
    };

    time.timeZone = "Asia/Seoul";

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
}
