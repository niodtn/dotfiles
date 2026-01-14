{
  flake,
  pkgs,
  config,
  ...
}: {
  imports = [flake.darwinModules.default];

  nix.enable = false; # Managed by Determinate

  features.trackpad.enable = true;
  features.safari.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = [
    pkgs.rectangle
    pkgs.betterdisplay
    pkgs.keka
  ];

  homebrew.brews = ["syncthing"];
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

  username = "niodtn";
  system.primaryUser = config.username; # nix-darwin
  nix-homebrew.user = config.username; # nix-homebrew
  users.users.${config.username}.home = "/Users/${config.username}";
}
