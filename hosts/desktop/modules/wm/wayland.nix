{
  lib,
  config,
  ...
}: let
  cfg = config.wm.wayland;
in {
  options = {
    wm.wayland = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    etc = {
      fonts = true;
      network = true;
      sound = true;
    };

    flake.aspects.desktop.nixos = lib.mkMerge [
      # XDG Portal
      ({pkgs, ...}: {
        environment.systemPackages = [pkgs.xdg-utils];

        xdg.portal = {
          enable = true;
          extraPortals = [pkgs.xdg-desktop-portal-gtk];
          config.common.default = lib.mkDefault ["gtk"];
        };
      })

      # Wayland
      {
        environment.variables = {NIXOS_OZONE_WL = "1";};
        programs.xwayland.enable = true;
      }

      # etc
      ({config, ...}: {
        users.users.${config.host.userName}.extraGroups = [
          "audio"
          "realtime"
          "video"
          "render"
        ];

        services.dbus.enable = true;

        security = {
          polkit.enable = true;
          rtkit.enable = true;
        };
      })
    ];
  };
}
