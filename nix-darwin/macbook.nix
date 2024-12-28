{config, pkgs, ...}:

{
  system.defaults.controlcenter.BatteryShowPercentage = true;

  # Enable touch ID support for sudo.
  security.pam.enableSudoTouchIdAuth = true;

  # Trackpad configuration
  system.defaults.trackpad.Clicking = true;
  # system.defaults.trackpad.TrackpadThreeFingerDrag = true;
}
