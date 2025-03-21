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
  ];

  homebrew.brews = [
    "mas"
  ];
  homebrew.casks = [
    "arc" # browser
    "discord"
    "obsidian"
    "moonlight"
    "guitar-pro"
    "anki"
    "filen"
    # "godot"
    # pkgs.betterdisplay

    # macOS Utils
    "rectangle" # Window Manager
    "linearmouse" # Mouse
    "hammerspoon" # Keyboard
    "tailscale" # Mesh VPN

    # Dev
    "warp" # Terminal
    "visual-studio-code" # editor

    # Fonts
    "font-sarasa-gothic"
    "jonz94/sarasa-nerd-fonts/font-sarasa-mono-k-nerd-font"
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
