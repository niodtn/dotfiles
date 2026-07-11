{pkgs, ...}: {
  environment.sessionVariables = {
    KWIN_IM_MODULE = "fcitx5";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-hangul
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
}
