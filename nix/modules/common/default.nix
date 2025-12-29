{ lib, pkgs, flake, ... }:
with lib;

{
  system.stateVersion = mkDefault "25.05";

  time.timeZone = "Asia/Seoul";

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style # For vscode Nix IDE extension
  ];

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

  nixpkgs = {
    hostPlatform = mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  home-manager.backupFileExtension = "backup";
}
