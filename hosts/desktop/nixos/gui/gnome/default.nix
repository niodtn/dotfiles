{
  imports = [
    ./dconf.nix
    ./dash-to-dock.nix
  ];

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
