{
  lib,
  pkgs,
  flake,
  ...
}:
with lib; {
  imports = [
    ./tailscale
    ./username.nix
    ./zsh.nix
  ];

  config = {
    system.stateVersion = mkDefault "26.05";

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
