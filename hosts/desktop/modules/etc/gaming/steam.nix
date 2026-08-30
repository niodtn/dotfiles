{
  lib,
  config,
  ...
}: let
  cfg = config.gaming.steam;
in {
  options = {
    gaming.steam = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    gaming = {
      gamemode = true;
      gamescope = true;
    };

    flake.aspects.desktop.nixos = lib.mkMerge [
      # Steam
      {
        programs = {
          steam = {
            enable = true;
            gamescopeSession.enable = true;

            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
          };
        };
      }

      # Proton
      ({
        pkgs,
        config,
        ...
      }: {
        programs.steam.extraCompatPackages = [pkgs.proton-ge-bin];

        home-manager.users.${config.host.userName} = {
          home.packages = with pkgs; [protontricks];
        };
      })

      # Modding
      ({config, ...}: {
        home-manager.users.${config.host.userName} = {pkgs, ...}: {
          home.packages = with pkgs; [
            amethyst-mod-manager
          ];
        };
      })

      # Niri Window Rules
      (lib.mkIf config.wm.niri ({config, ...}: {
        home-manager.users.${config.host.userName} = {
          wayland.windowManager.niri.settings = {
            _children = [
              {
                window-rule._children = [
                  {match._props = {app-id = "r\"steam\"";};}
                  {open-maximized = true;}
                  {open-floating = false;}
                ];
              }

              {
                window-rule._children = [
                  {match._props = {app-id = "r\"cs2\"";};}
                  {open-fullscreen = true;}
                  {open-floating = true;}
                  # {variable-refresh-rate = true;}
                  # {allow-tearing = {};}
                ];
              }
            ];
          };
        };
      }))

      # etc
      ({pkgs, ...}: {
        environment.systemPackages = with pkgs; [
          adwsteamgtk
          vulkan-tools
        ];
      })
    ];
  };
}
