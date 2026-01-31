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
    zsh.enable = true;
    tailscale.enable = true;

    ## shell
    atuin.enable = true;
    direnv.enable = true;
    git.enable = true;
    jujutsu.enable = true;
    python.enable = true;
    sshfs.enable = true;
    starship.enable = true;

    ## gui
    ghostty.enable = true;
    vesktop.enable = true;
    zen-browser.enable = true;
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
  ];

  homebrew = {
    brews = [
      "syncthing"
    ];

    casks = [
      "guitar-pro"
      "obsidian"
      "linearmouse" # Mouse

      # Dev
      # "finch"
    ];

    masApps = {
      # "Folder Hub" = 6473019059;
      "Amphetamine" = 937984704;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  username = "niodtn";
}
