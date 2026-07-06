let
  allDevices = {
    "iphone" = {
      id = "C4SHE6C-L42LP3X-N5F3L5V-YFKBV5O-V2VKRS2-EDH3DPU-N5VL4MI-IN5XVAX";
      addresses = ["tcp://iphone:22000"];
      autoAcceptFolders = true;
    };
    "ipad" = {
      id = "MAESBG3-2ZPIZHV-P2SJULR-MDFJFG7-B5DSKUR-R6MTOGK-WJWEVKC-EQOC5QO";
      addresses = ["tcp://ipad:22000"];
      autoAcceptFolders = true;
    };
    "desktop" = {
      id = "PTWTQLV-JXWYFDX-PJ4VIB4-RFARNYH-ERUBUNB-URZFTRK-NQ5LOQ7-2Q466AY";
      addresses = ["tcp://desktop:22000"];
      autoAcceptFolders = true;
    };
    "mac" = {
      id = "QPPT65R-E42JVJ4-2FJVVNY-Y3TEOR5-4OYIOOZ-EMLAGHA-V4PKG4O-3ZRAZA4";
      addresses = ["tcp://mac:22000"];
      autoAcceptFolders = true;
    };
  };

  common = {config, ...} @ sys: {
    home-manager.users.${config.host.userName} = {config, ...} @ hm: {
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
            "Downloads".path = "${hm.config.home.homeDirectory}/Downloads";
          };

          devices = removeAttrs allDevices [sys.config.host.hostName];
        };
      };
    };
  };
in {
  flake.aspects = {aspects, ...}: {
    syncthing = {
      includes = with aspects; [tailscale];
      nixos = common;
      darwin = common;
    };
  };
}
