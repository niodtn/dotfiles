{
  config,
  lib,
  ...
}: let
  cfg = config.nixos.wayland.enable;
in {
  options = {
    nixos.wayland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.wayland.nixos = lib.mkMerge [
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
