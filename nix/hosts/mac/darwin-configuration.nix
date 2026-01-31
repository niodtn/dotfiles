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

    vscode = {
      enable = true;
      nix.enable = true;
      markdown.enable = true;
    };

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
    # pkgs.vesktop
  ];

  homebrew = {
    taps = ["macos-fuse-t/homebrew-cask"];

    brews = [
      "syncthing"
    ];

    casks = [
      "guitar-pro"
      "obsidian"
      "discord"
      "zen"
      "vesktop"

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
