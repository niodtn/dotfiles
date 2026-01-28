{
  flake,
  pkgs,
  perSystem,
  config,
  ...
}: {
  imports = [flake.darwinModules.default];

  nix.enable = false; # Managed by Determinate

  features = {
    # common
    zsh.enable = true;
    tailscale.enable = true;
    sshfs.enable = true;
    ghostty.enable = true;
    vesktop.enable = true;

    # darwin
    hammerspoon.enable = true;
    trackpad.enable = true;
    safari.enable = true;
  };

  environment.systemPackages = [
    pkgs.rectangle
    pkgs.betterdisplay
    pkgs.keka
    perSystem.self.iloader
  ];

  homebrew = {
    brews = [
      "syncthing"
    ];

    casks = [
      "guitar-pro"
      "obsidian"
      "zen"

      "linearmouse" # Mouse

      # Dev
      # "finch"
    ];

    masApps = {
      # "Folder Hub" = 6473019059;
      "Amphetamine" = 937984704;
      # "Bitwarden" = 1352778147;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  username = "niodtn";
}
