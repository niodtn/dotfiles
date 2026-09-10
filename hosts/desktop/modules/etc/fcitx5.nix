{
  config,
  lib,
  ...
}: let
  cfg = config.etc.fcitx5;
in {
  options = {
    etc.fcitx5 = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.desktop.nixos = lib.mkMerge [
      {
        environment.variables = {
          # GTK_IM_MODULE = "fcitx";
          # QT_IM_MODULE = "fcitx";
          XMODIFIERS = "@im=fcitx";
        };
      }

      ({
        config,
        pkgs,
        ...
      }: {
        home-manager.users.${config.host.userName} = {
          i18n.inputMethod = {
            enable = true;
            type = "fcitx5";

            fcitx5 = {
              waylandFrontend = true;

              addons = with pkgs; [
                fcitx5-gtk
                fcitx5-hangul
                fcitx5-mozc
              ];

              settings = {
                globalOptions = {
                  Behavior.ActiveByDefault = false;

                  "Hotkey/TriggerKeys" = {
                    "0" = "Alt_R";
                  };
                };

                inputMethod = {
                  "GroupOrder" = {
                    "0" = "KO";
                    "1" = "JA";
                  };

                  "Groups/0" = {
                    "Name" = "KO";
                    "Default Layout" = "us";
                    "DefaultIM" = "hangul";
                  };

                  "Groups/1" = {
                    "Name" = "JA";
                    "Default Layout" = "us";
                    "DefaultIM" = "mozc";
                  };

                  "Groups/0/Items/0" = {"Name" = "keyboard-us";};
                  "Groups/1/Items/0" = {"Name" = "keyboard-us";};

                  "Groups/0/Items/1" = {
                    "Name" = "hangul";
                    "Layout" = "us";
                  };
                  "Groups/1/Items/1" = {
                    "Name" = "mozc";
                    "Layout" = "us";
                  };
                };
              };
            };
          };
        };
      })
    ];
  };
}
