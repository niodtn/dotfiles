{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.lsd # `ls` command
    pkgs.bat # `cat` command
    pkgs.nixfmt-rfc-style # For vscode Nix IDE extension
    pkgs.stow
    pkgs.vim
    pkgs.aider-chat
    pkgs.just

    # Shell
    pkgs.zsh-autosuggestions
    pkgs.fzf
    pkgs.zsh-fzf-tab

    # Utilities
    pkgs.rectangle
    pkgs.betterdisplay
    pkgs.keka

    pkgs.spotify
  ];

  homebrew.brews = [
    "mas"
  ];
  homebrew.casks = [
    "guitar-pro"
    "tailscale"
    "linearmouse" # Mouse
    "hammerspoon" # Keyboard
    "obsidian"
    "moonlight"
    "anki"
    "filen"

    # Auto-updating apps (no need for brew upgrades)
    "arc" # browser
    "discord"
    "warp" # Terminal
    "visual-studio-code" # editor

    # Fonts
    "font-sarasa-gothic"
    "font-jetbrains-mono-nerd-font"
  ];
  homebrew.taps = [
    "jonz94/sarasa-nerd-fonts"
  ];
  homebrew.masApps = {
    #   "Folder Hub" = 6473019059;
    "Amphetamine" = 937984704;
  };
}
