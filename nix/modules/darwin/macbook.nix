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
