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
    ./ghostty.nix
    ./openssh.nix
    ./sshfs.nix
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
      if isLinux
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

    environment.systemPackages = with pkgs; [comma];

    time.timeZone = "Asia/Seoul";
    home-manager.backupFileExtension = "backup";
  };
}
