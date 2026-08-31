{
  lib,
  config,
  ...
}: let
  cfg = config.gaming.gamemode;
in {
  options = {
    gaming.gamemode = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = {config, ...}: {
      programs.gamemode.enable = true;
      users.users.${config.host.userName}.extraGroups = ["gamemode"];
    };
  };
}
