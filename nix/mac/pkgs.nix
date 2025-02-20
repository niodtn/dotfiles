{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.lsd # `ls` command
    pkgs.bat # `cat` command
    pkgs.nixfmt-rfc-style # For vscode Nix IDE extension
    pkgs.stow
    pkgs.vim

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
    "cursor" # editor
    "discord"
    "obsidian"
    "moonlight"
    {
      name = "guitar-pro";
      greedy = true;
    }
    # "filen"
    # "godot"
    # pkgs.betterdisplay

    # macOS Utils
    "rectangle"
    "tailscale"
    "linearmouse"
    "hammerspoon"

    # Terminal
    "warp"
    # "wave"

    # Fonts
    "font-sarasa-gothic"
    "jonz94/sarasa-nerd-fonts/font-sarasa-mono-k-nerd-font"
    "font-jetbrains-mono-nerd-font"
    "font-hack-nerd-font"
  ];
  # homebrew.masApps = {
  #   "Folder Hub" = 6473019059;
  #   "Amphetamine" = 937984704;
  # };
}
