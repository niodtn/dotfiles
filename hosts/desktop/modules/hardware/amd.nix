{
  lib,
  config,
  ...
}: let
  cfg = config.hardware.amd;
in {
  options = {
    hardware.amd = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.core.nixos = {config, ...}: {
      boot.kernelModules = ["kvm-amd"];
      hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
    };
  };
}
