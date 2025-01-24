{ config, pkgs, ... }:

{
  environment.systemPackages = [
    # CLI tools
    pkgs.devenv
    pkgs.nixfmt-rfc-style
    pkgs.bat
    pkgs.neofetch

    # pkgs.betterdisplay
    # pkgs.rectangle

    pkgs.iterm2
    # pkgs.obsidian
  ];

  homebrew = {
    enable = true;
    brews = [
      "mas"
      "fzf"
      "oh-my-posh"
      "starship"
    ];
    casks = [
      "tailscale"
      "font-jetbrains-mono-nerd-font"
      # "guitar-pro"
      # "linearmouse"
    ];
    # masApps = {
    #   "Folder Hub" = 6473019059;
    #   "Amphetamine" = 937984704;
    # };
    onActivation.cleanup = "zap";
  };
}
