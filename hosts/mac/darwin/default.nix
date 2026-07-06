{lib, ...}: {
  imports = [
    ./kanata.nix
    ./scroll-reverser.nix
  ];

  config = lib.mkMerge [
    # Dock
    {
      system.defaults.dock = {
        autohide = true;
        minimize-to-application = true;
        mru-spaces = false;
        scroll-to-open = true;
        show-recents = false;
        mineffect = "scale";

        # corners
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };
    }

    # Finder
    {
      system.defaults.finder = {
        ShowStatusBar = true;
        ShowPathbar = true;
        FXRemoveOldTrashItems = true;
        AppleShowAllExtensions = true;
        _FXEnableColumnAutoSizing = true;
        _FXSortFoldersFirst = true;
        FXEnableExtensionChangeWarning = false;
      };
    }

    # Keyboard
    {
      system.defaults.NSGlobalDomain = {
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
    }

    # Macbook
    {
      # TouchID
      security.pam.services.sudo_local.touchIdAuth = true;

      # Battery
      system.defaults.controlcenter.BatteryShowPercentage = true;

      # Trackpad
      system.defaults.trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
        ActuationStrength = 0;
        FirstClickThreshold = 0;
        SecondClickThreshold = 0;
      };
    }

    # etc
    {
      system.defaults = {
        WindowManager = {
          EnableTiledWindowMargins = false;
          EnableStandardClickToShowDesktop = false;
        };

        NSGlobalDomain = {
          AppleShowScrollBars = "WhenScrolling";
          NSDocumentSaveNewDocumentsToCloud = false;
          NSNavPanelExpandedStateForSaveMode = true;

          # Menu Bar
          AppleICUForce24HourTime = true;
          _HIHideMenuBar = false;
        };
      };
    }
  ];
}
