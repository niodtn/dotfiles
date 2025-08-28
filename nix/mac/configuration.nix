# https://daiderd.com/nix-darwin/manual/index.html

{ config, pkgs, ... }:

{
  imports = [
    ../common/pkgs.nix
    ./pkgs.nix
  ];

  nix.enable = false;
  system.primaryUser = "niodtn";
  users.users.niodtn.home = "/Users/niodtn";

  # For pkgs.nix
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nix-homebrew.enable = true;
  nix-homebrew.enableRosetta = true;
  nix-homebrew.autoMigrate = true;
  nix-homebrew.user = "niodtn";
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.onActivation.upgrade = true;

  # Security
  security.pam.services.sudo_local.touchIdAuth = true;

  # Status Bar
  system.defaults.controlcenter.BatteryShowPercentage = true;
  system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;

  # Dock
  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
  system.defaults.dock.autohide = true;
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.wvous-bl-corner = 1;
  system.defaults.dock.wvous-br-corner = 1;
  system.defaults.dock.wvous-tl-corner = 1;
  system.defaults.dock.wvous-tr-corner = 1;
  system.defaults.dock.mineffect = "scale";

  # Finder
  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/finder.nix
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.AppleShowAllExtensions = true;

  # Keyboard
  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
  system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # Trackpad
  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.trackpad.ActuationStrength = 0;
  system.defaults.trackpad.FirstClickThreshold = 0;
  system.defaults.trackpad.SecondClickThreshold = 0;

  # Window Manager
  system.defaults.WindowManager.EnableTiledWindowMargins = false;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;
}
