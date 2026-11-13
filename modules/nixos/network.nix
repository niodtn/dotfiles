{
  lib,
  config,
  ...
}: let
  cfg = config.nixos.network;
in {
  options = {
    nixos.network = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.core.nixos = {config, ...}: {
      firewall.enable = true;
      
      # networkmanager
      networking.networkmanager.enable = true;
      users.users.${config.host.userName}.extraGroups = ["networkmanager"];
    };
  };
}
