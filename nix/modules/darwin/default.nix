{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  username = config.username;
in {
  imports = [
    inputs.mac-app-util.darwinModules.default
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../common
    ./hammerspoon.nix
    ./safari.nix
    ./trackpad.nix
  ];

  # https://daiderd.com/nix-darwin/manual/index.html
  config = {
    nixpkgs.hostPlatform = "aarch64-darwin";

    # networking.computerName = lib.mkDefault "mac";

    system = {
      primaryUser = config.username;
      stateVersion = 6; # https://github.com/LnL7/nix-darwin/blob/master/modules/examples/flake/flake.nix

      defaults = {
        controlcenter.BatteryShowPercentage = true;

        # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
        dock = {
          autohide = true;
          minimize-to-application = true;
          mru-spaces = false;
          scroll-to-open = true;
          show-recents = false;
          # static-only = true;
          mineffect = "scale";

          # corners
          wvous-bl-corner = 1;
          wvous-br-corner = 1;
          wvous-tl-corner = 1;
          wvous-tr-corner = 1;
        };

        # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/finder.nix
        finder = {
          ShowStatusBar = true;
          ShowPathbar = true;
          FXRemoveOldTrashItems = true;
          AppleShowAllExtensions = true;
          _FXEnableColumnAutoSizing = true;
          _FXSortFoldersFirst = true;
          FXEnableExtensionChangeWarning = false;
        };

        WindowManager = {
          EnableTiledWindowMargins = false;
          EnableStandardClickToShowDesktop = false;
        };

        # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
        NSGlobalDomain = {
          AppleShowScrollBars = "WhenScrolling";
          NSDocumentSaveNewDocumentsToCloud = false;
          NSNavPanelExpandedStateForSaveMode = true;

          # Menu Bar
          AppleICUForce24HourTime = true;
          _HIHideMenuBar = false;

          # Keyboard
          "com.apple.keyboard.fnState" = true;
          ApplePressAndHoldEnabled = false;
          InitialKeyRepeat = 10;
          KeyRepeat = 1;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticInlinePredictionEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
        };
      };
    };

    nix = {
      enable = lib.mkDefault true;
      gc.automatic = config.nix.enable;
    };

    homebrew = {
      enable = true;
      onActivation.cleanup = "zap";
      onActivation.upgrade = true;
      brews = ["mas"];
    };

    nix-homebrew = {
      enable = true;
      user = config.username;
      enableRosetta = true;
      autoMigrate = true;
    };
  };
}
