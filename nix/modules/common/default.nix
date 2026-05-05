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
    ./spicetify.nix
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
    users.users.${username}.home =
      if pkgs.stdenv.hostPlatform.isLinux
      then "/home/${username}"
      else "/Users/${username}";

    nix = {
      gc = {
        automatic = mkDefault true;
        options = "--delete-older-than 30d";
      };

      settings = {
        auto-optimise-store = true;
      };
    };

    time.timeZone = "Asia/Seoul";
  };
}
