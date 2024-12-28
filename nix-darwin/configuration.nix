{ config, pkgs, ... }:

{
  environment.darwinConfig = "$HOME/.config/nix-darwin/configuration.nix";
  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  # nix.settings.warn-dirty = false;
  # nix.gc.automatic = true;

  # Enable touch ID support for sudo.
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.WindowManager.EnableTiledWindowMargins = false;
  system.defaults.controlcenter.BatteryShowPercentage = true;

  # Trackpad configuration
  system.defaults.trackpad.Clicking = true;
  # system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  # system.defaults.trackpad.FirstClickThreshold = 0;
  # system.defaults.trackpad.SecondClickThreshold = 0;

  # Dock configuration
  system.defaults.dock.autohide = true;
  system.defaults.dock.show-recents = false;

  # Hot corners configuration
  system.defaults.dock.wvous-bl-corner = 1;
  system.defaults.dock.wvous-br-corner = 1;
  system.defaults.dock.wvous-tl-corner = 1;
  system.defaults.dock.wvous-tr-corner = 1;

  # system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = boolean;

  # direnv configuration
  programs.direnv.enable = true;

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
