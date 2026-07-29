{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gui
    ./hardware
  ];

  config = lib.mkMerge [
    # Network
    {
      networking = {
        networkmanager.enable = true;
        firewall = {
          enable = true;
          trustedInterfaces = ["tailscale0"];
        };
      };

      users.users.${config.host.userName}.extraGroups = ["networkmanager"];
    }

    # etc
    {
      fonts.packages = [pkgs.noto-fonts-cjk-sans];
    }
  ];
}
