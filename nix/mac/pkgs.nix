{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.lsd # `ls` command
    pkgs.bat # `cat` command
    pkgs.nixfmt-rfc-style # For vscode Nix IDE extension
    pkgs.stow
    pkgs.vim
    pkgs.aider-chat

    # Shell
    pkgs.zsh-autosuggestions
    pkgs.fzf
    pkgs.zsh-fzf-tab

    # Utilities
    pkgs.rectangle
    pkgs.betterdisplay
    pkgs.keka
  ];

  homebrew.brews = [
    "mas"
  ];
  homebrew.casks = [
    # Auto-updating apps (no need for brew upgrades)
    "arc" # browser
    "discord"
    "warp" # Terminal
    "visual-studio-code" # editor

    # update apps with `greedy`
    {
      name = "guitar-pro";
      greedy = true;
    }
    {
      name = "tailscale";
      greedy = true;
    }

    # ?
    "linearmouse" # Mouse
    "hammerspoon" # Keyboard
    "obsidian"
    "moonlight"
    "anki"
    "filen"

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
