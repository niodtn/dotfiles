{
  config,
  lib,
  ...
}: let
  cfg = config.nixos.wayland.plasma;
in {
  options = {
    nixos.wayland.plasma = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    inputs.plasma-manager = true;

    nixos.wayland = {
      enable = true;
      fcitx5 = true;
    };

    flake.aspects.wayland.nixos = lib.mkMerge [
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
            overrideConfig = true;

            workspace = {
              iconTheme = "Papirus-Dark";
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
                  {
                    digitalClock = {
                      date.format = "isoDate";
                      time.format = "24h";
                    };
                  }
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
