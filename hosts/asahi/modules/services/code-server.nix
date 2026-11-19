{lib, ...}: {
  flake.aspects.asahi.nixos = lib.mkMerge [
    {
      services.code-server = {
        enable = true;
        host = "0.0.0.0";
        auth = "none";

        disableUpdateCheck = true;
        disableWorkspaceTrust = true;
      };
    }

    ({config, ...}:{
      services.code-server = {
        user = config.host.userName;
        group = "users";
      };
    })
  ];
}
