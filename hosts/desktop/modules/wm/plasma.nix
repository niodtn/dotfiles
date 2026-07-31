{
  lib,
  config,
  ...
}: let
  cfg = config.wm.plasma;
in {
  options = {
    wm.plasma = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    inputs.plasma-manager = true;

    wm.wayland = true;

    etc = {
      fonts = true;
      fcitx5 = true;
      network = true;
      sound = true;
    };

    flake.aspects.host-desktop.nixos = lib.mkMerge [
      # XDG Portal
      ({pkgs, ...}: {
        xdg.portal = {
          extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
          config.kde.default = ["kde" "gtk"];
        };
      })

      # KDE Plasma
      ({config, ...}: {
        services = {
          displayManager.sddm.enable = true;
          desktopManager.plasma6.enable = true;
        };

        home-manager.users.${config.host.userName}.programs.plasma.enable = true;
      })

      # Fcitx5
      {
        environment.sessionVariables = {
          KWIN_IM_MODULE = "fcitx5";
        };
      }

      # Mouse
      {
        services.libinput = {
          enable = true;
          mouse = {
            accelProfile = "flat";
            accelSpeed = "0";
          };
        };
      }

      # AutoLogin
      ({config, ...}: {
        services.displayManager.autoLogin = {
          enable = true;
          user = config.host.userName;
        };
      })
    ];
  };
}
