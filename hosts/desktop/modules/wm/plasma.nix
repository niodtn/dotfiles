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
    etc.fcitx5 = true;

    flake.aspects.desktop.nixos = lib.mkMerge [
      # XDG Portal
      ({pkgs, ...}: {
        xdg.portal = {
          extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
          config.kde.default = ["kde" "gtk"];
        };
      })

      # Fcitx5
      {
        environment.sessionVariables = {
          KWIN_IM_MODULE = "fcitx5";
        };
      }

      # Mouse
      ({config, ...}: {
        services.libinput = {
          enable = true;
          mouse = {
            accelProfile = "flat";
            accelSpeed = "0";
          };
        };

        home-manager.users.${config.host.userName}.programs.plasma = {
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
      })

      # AutoLogin
      ({config, ...}: {
        services.displayManager.autoLogin = {
          enable = true;
          user = config.host.userName;
        };
      })

      # Plasma
      ({
        config,
        pkgs,
        ...
      }: {
        services = {
          displayManager.sddm.enable = true;
          desktopManager.plasma6.enable = true;
        };

        home-manager.users.${config.host.userName} = {
          home.packages = with pkgs; [
            papirus-icon-theme
          ];

          programs.plasma = {
            enable = true;

            workspace = {
              wallpaper = "/home/niodtn/Pictures/Wallpapers/Palette 08.jpg";
            };

            kwin = {
              edgeBarrier = 0;
              cornerBarrier = false;
            };

            panels = [
              {
                location = "top";
                height = 36;
                widgets = [
                  {
                    kickoff = {
                      sortAlphabetically = true;
                      icon = "nix-snowflake-white";
                    };
                  }
                  "org.kde.plasma.panelspacer"

                  "org.kde.plasma.icontasks"
                  "org.kde.plasma.panelspacer"

                  "org.kde.plasma.systemtray"
                  "org.kde.plasma.digitalclock"
                ];
              }
            ];

            configFile = {
              "kwinrc"."Effect-overview"."BorderActivate" = "9"; # Hot Corner Off
            };
          };
        };
      })
    ];
  };
}
