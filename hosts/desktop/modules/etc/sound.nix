{
  lib,
  config,
  ...
}: let
  cfg = config.etc.sound;
in {
  options = {
    etc.sound = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = {
      security.rtkit.enable = true;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
  };
}
