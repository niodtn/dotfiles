{
  lib,
  config,
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
    flake.aspects.host-desktop.nixos = {pkgs, ...}: {
      environment.variables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
      };

      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          waylandFrontend = true;
          addons = with pkgs; [
            fcitx5-hangul
            fcitx5-gtk
          ];
          settings = {
            inputMethod = {
              "Groups/0" = {
                Name = "Default";
                "Default Layout" = "us";
              };
              "Groups/0/Items/0" = {Name = "keyboard-us";};
              "Groups/0/Items/1" = {Name = "hangul";};
            };
            globalOptions = {
              "Hotkey/TriggerKeys" = {
                "0" = "Control+space";
                "1" = "Alt_R";
              };
            };
          };
        };
      };
    };
  };
}
