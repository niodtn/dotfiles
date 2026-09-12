{
  config,
  lib,
  ...
}: let
  cfg = config.nixos.wayland.enable;
in {
  config = lib.mkIf cfg {
    etc = {
      fonts = true;
      network = true;
      sound = true;
    };
  };
}
