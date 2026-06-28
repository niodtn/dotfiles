{config, ...}: {
  imports = [
    ./dconf.nix
    ./dash-to-dock.nix
  ];

  services = {
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = config.host.userName;
      };
    };
    desktopManager.gnome.enable = true;
  };
}
