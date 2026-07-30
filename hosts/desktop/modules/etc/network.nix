{
  lib,
  config,
  ...
}: let
  cfg = config.etc.network;
in {
  options = {
    etc.network = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = {config, ...}: {
      networking = {
        networkmanager.enable = true;
        firewall = {
          enable = true;
          trustedInterfaces = ["tailscale0"];
        };
      };

      users.users.${config.host.userName}.extraGroups = ["networkmanager"];
    };
  };
}
