{
  lib,
  config,
  pkgs,
  flake,
  ...
}:
with lib; let
  username = config.username;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in {
  imports = [
    ./tailscale
    ./openssh.nix
    ./username.nix
    ./zsh.nix
  ];

  config = {
    system.stateVersion = mkDefault "26.05";

    users.users.${config.username}.home =
      if isLinux
      then "/home/${config.username}"
      else "/Users/${config.username}";

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

    environment.systemPackages = with pkgs; [comma];

    time.timeZone = "Asia/Seoul";
    home-manager.backupFileExtension = "backup";
  };
}
