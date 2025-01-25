{ pkgs, ... }:

{
  environment.systemPackages = [
    # pkgs.zsh-autocomplete
    # pkgs.zsh-autosuggestions

    pkgs.fzf
    pkgs.bat
    pkgs.nixfmt-rfc-style

    pkgs.iterm2
    # pkgs.betterdisplay
    # pkgs.rectangle
    # pkgs.obsidian
  ];

  homebrew.brews = [
    "mas"
    "oh-my-posh"
    "starship"
  ];
  homebrew.casks = [
    "font-jetbrains-mono-nerd-font"
    "tailscale"
    "filen"
    # "godot"
    # "guitar-pro"
    # "linearmouse"
  ];
  # homebrew.masApps = {
  #   "Folder Hub" = 6473019059;
  #   "Amphetamine" = 937984704;
  # };

}
