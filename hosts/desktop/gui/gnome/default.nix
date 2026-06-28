{config, ...}: {
  imports = [
    ./dconf.nix
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
