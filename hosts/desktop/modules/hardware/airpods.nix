{
  lib,
  config,
  ...
}: let
  cfg = config.hardware.airpods;
in {
  options = {
    hardware.airpods = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    hardware.bluetooth = true;

    flake.aspects.host-desktop.nixos = {config, ...}: {
      services.pipewire.wireplumber.enable = true;

      programs.librepods.enable = true;
      users.users.${config.host.userName}.extraGroups = ["librepods"];
    };
  };
}
