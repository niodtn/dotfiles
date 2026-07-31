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

      (lib.mkIf config.wm.plasma ({pkgs, ...}: {
        environment.systemPackages = [
          pkgs.adwsteamgtk
        ];
      }))
    ];
  };
}
