{
  config,
  lib,
  ...
}: let
  cfg = config.nixos.wayland.hyprland;
in {
  options = {
    nixos.wayland.hyprland = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    inputs.home-manager = true;

    nixos = {
      wayland = {
        enable = true;
        fcitx5 = true;
      };

      services.greetd = true;
    };

    flake.aspects.wayland.nixos = lib.mkMerge [
      # Portal
      ({pkgs, ...}: {
        xdg.portal = {
          enable = true;
          extraPortals = [pkgs.xdg-desktop-portal-hyprland];
        };
      })

      # Greetd
      {
        services.greetd.settings.default_session.command = "start-hyprland";
      }

      # Hyprland
      ({config, ...}: {
        programs.hyprland.enable = true;

        home-manager.users.${config.host.userName} = {
          wayland.windowManager.hyprland = {
            enable = true;
            configType = "lua";

            extraLuaFiles = {
              "etc" = ./hyprland.lua;
            };
          };
        };
      })
    ];
  };
}
