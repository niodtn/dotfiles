{ flake, pkgs, ... }:

let
  username = "niodtn";
in
{
  imports = [
    flake.darwinModules.default
    flake.modules.darwin.homebrew
  ];

  nix.enable = false; # Managed by Determinate

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = [
    pkgs.rectangle
    pkgs.betterdisplay
    pkgs.keka
  ];

  homebrew.brews = [ "syncthing" ];
  homebrew.casks = [
    "guitar-pro"
    "obsidian"
    "discord"
    "zen"

    "tailscale-app"
    "linearmouse" # Mouse
    "hammerspoon" # Keyboard

    # Dev
    "warp"
    # "finch"
  ];
  homebrew.masApps = {
    # "Folder Hub" = 6473019059;
    "Amphetamine" = 937984704;
    # "Bitwarden" = 1352778147;
  };

  system.primaryUser = username; # nix-darwin
  nix-homebrew.user = username; # nix-homebrew
  users.users.${username}.home = "/Users/${username}";
}
