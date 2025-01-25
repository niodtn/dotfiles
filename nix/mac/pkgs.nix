{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.lsd # `ls` command
    pkgs.bat # `cat` command
    pkgs.nixfmt-rfc-style # For vscode Nix IDE extension
    pkgs.stow
    pkgs.zsh-autosuggestions

    # pkgs.fzf
    # pkgs.betterdisplay
    # pkgs.rectangle
    # pkgs.obsidian
  ];

  homebrew.brews = [ "mas" ];
  homebrew.casks = [
    "font-jetbrains-mono-nerd-font"
    "font-hack-nerd-font"
    "tailscale"
    "filen"
    # "godot"
    # "guitar-pro"
    # "linearmouse"
  # Terminal
    "warp"
    # "wave"
  ];
  # homebrew.masApps = {
  #   "Folder Hub" = 6473019059;
  #   "Amphetamine" = 937984704;
  # };

}
