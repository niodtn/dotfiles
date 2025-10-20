{ config, inputs, pkgs, ... }:

{
  imports = [
    inputs.mac-app-util.darwinModules.default
    ../common
  ];

  # https://daiderd.com/nix-darwin/manual/index.html
  config = {
    nix.enable = false;

    system.defaults = {
      controlcenter.BatteryShowPercentage = true;

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
      dock = {
        autohide = true;
        minimize-to-application = true;
        mru-spaces = false;
        show-recents = false;
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
        AppleShowAllExtensions = true;
      };

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
        ActuationStrength = 0;
        FirstClickThreshold = 0;
        SecondClickThreshold = 0;
      };

      WindowManager = {
        EnableTiledWindowMargins = false;
        EnableStandardClickToShowDesktop = false;
      };

      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;

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
}
