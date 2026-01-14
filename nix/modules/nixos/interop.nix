{pkgs, ...}: {
  services.dbus.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = [pkgs.xdg-utils];
}
