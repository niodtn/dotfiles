{config, ...}: {
  services.syncthing = {
    enable = true;
    overrideFolders = false;
    overrideDevices = false;

    settings = {
      options = {
        natEnabled = false;
        relaysEnabled = false;
        localAnnounceEnabled = false;
        globalAnnounceEnabled = false;
      };

      folders = {
        "Downloads".id = "downloads";
        "Downloads".path = "${config.home.homeDirectory}/Downloads";
      };
    };
  };
}
