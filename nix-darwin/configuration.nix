{ config, pkgs, ... }:

{
  environment.darwinConfig = "$HOME/.config/nix-darwin/configuration.nix";
  services.nix-daemon.enable = true;

  # font.packages = [ ];

  # Trackpad configuration
  system.defaults.trackpad.Clicking = true;
  # system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  # system.defaults.trackpad.FirstClickThreshold = 0;
  # system.defaults.trackpad.SecondClickThreshold = 0;

  # system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = boolean;

  # zsh configuration
  # programs.zsh.enable = true;
  # programs.zsh.enableBashCompletion = true;
  # programs.zsh.enableCompletion = true;
  # programs.zsh.enableFastSyntaxHighlighting = true;
  # programs.zsh.enableFzfCompletion = true;
  # programs.zsh.enableFzfGit = true;
  # programs.zsh.enableSyntaxHighlighting = true;

  # tmux configuration
  # programs.tmux.enable = true;
  # programs.tmux.enableMouse = true;
  # programs.tmux.iTerm2 = true;
}
