{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.scroll-reverser
  ];

  system.defaults.CustomUserPreferences = {
    "com.pilotmoon.scroll-reverser" = {
      ReverseMouse = true;
      ReverseTrackpad = false;
      HideIcon = true;
    };
  };
}
