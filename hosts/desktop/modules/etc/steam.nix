{
  lib,
  config,
  ...
}: let
  cfg = config.etc.steam;
in {
  options = {
    etc.steam = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = lib.mkMerge [
      # Gamepad
      {
        hardware = {
          steam-hardware.enable = true;
          xpadneo.enable = true;
        };
      }

      # Steam
      ({pkgs, ...}: {
        programs = {
          steam = {
            enable = true;
            gamescopeSession.enable = true;
            extraCompatPackages = [pkgs.proton-ge-bin];
          };

          gamemode.enable = true;
          gamescope = {
            enable = true;
            capSysNice = false;
          };
        };
      })

      # Palworld
      {
        networking.firewall.allowedUDPPorts = [8211];
        networking.firewall.allowedTCPPorts = [8211];
      }

      # Modding
      ({config, ...}: {
        home-manager.users.${config.host.userName} = {pkgs, ...}: {
          home.packages = with pkgs; [
            protontricks
            amethyst-mod-manager
          ];
        };
      })

      # etc
      (lib.mkIf config.wm.plasma ({pkgs, ...}: {
        environment.systemPackages = [
          pkgs.adwsteamgtk
        ];
      }))
    ];
  };
}
