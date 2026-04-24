{
  flake,
  pkgs,
  perSystem,
  config,
  ...
}: {
  imports = [flake.darwinModules.default];

  features = {
    zsh.enable = true;
    tailscale.enable = true;

    ## shell
    atuin.enable = true;
    comma.enable = true;
    direnv.enable = true;
    git.enable = true;
    jujutsu.enable = true;
    python.enable = true;
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
    #safari.enable = true;
  };

  environment.systemPackages = [
    pkgs.rectangle
    pkgs.betterdisplay # License key is in Bitwarden
    perSystem.self.finetune
  ];

  homebrew = {
    brews = [
      "syncthing"
    ];

    casks = [
      "obsidian"
      "linearmouse" # Mouse
      "prismlauncher"
      "spotify"

      # Dev
      # "finch"
    ];

    masApps = {
      "Folder Hub" = 6473019059;
      "Amphetamine" = 937984704;
    };
  };

  username = "niodtn";
}
