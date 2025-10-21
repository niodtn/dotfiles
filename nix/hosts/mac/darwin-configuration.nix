{ flake, pkgs, ... }:

{
  imports = [
    flake.darwinModules.default
    flake.modules.darwin.homebrew
  ];

  system.primaryUser = "niodtn"; # nix-darwin
  nix-homebrew.user = "niodtn"; # nix-homebrew
  users.users.niodtn.home = "/Users/niodtn"; # home-manager

  nix.enable = false; # Managed by Determinate

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = [
    pkgs.rectangle
    pkgs.betterdisplay
    pkgs.keka
  ];

  homebrew.casks = [
    "guitar-pro"
    "obsidian"
    # "anki"
    # "filen"
    "discord"
    "google-chrome"

    "tailscale-app"
    "linearmouse" # Mouse
    "hammerspoon" # Keyboard

    # Dev
    "warp"
    "visual-studio-code"
    # "finch"
  ];
  homebrew.masApps = {
    # "Folder Hub" = 6473019059;
    "Amphetamine" = 937984704;
    # "Bitwarden" = 1352778147;
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6; # https://github.com/LnL7/nix-darwin/blob/master/modules/examples/flake/flake.nix
}
