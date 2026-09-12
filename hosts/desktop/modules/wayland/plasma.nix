{
  config,
  lib,
  ...
}: let
  cfg = config.nixos.wayland.plasma;
in {
  config = lib.mkIf cfg {
    flake.aspects.wayland.nixos = {config, ...}: {
      home-manager.users.${config.host.userName}.programs.plasma = {
        workspace.wallpaper = "/home/niodtn/Pictures/Wallpapers/Palette 08.jpg";

        input.mice = [
          {
            accelerationProfile = "none";

            # /proc/bus/input/devices
            vendorId = "3554";
            productId = "f503";
            name = "Compx VGN Mouse 2.4G Receiver";
          }
        ];
      };
    };
  };
}
