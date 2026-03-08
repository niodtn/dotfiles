{pkgs, ...}: {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-hangul
        ];
        settings.inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
          };
          "Groups/0/Items/0" = {Name = "keyboard-us";};
          "Groups/0/Items/1" = {Name = "hangul";};
        };
      };
    };

    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "ko_KR.UTF-8";
      LC_IDENTIFICATION = "ko_KR.UTF-8";
      LC_MEASUREMENT = "ko_KR.UTF-8";
      LC_MONETARY = "ko_KR.UTF-8";
      LC_NAME = "ko_KR.UTF-8";
      LC_NUMERIC = "ko_KR.UTF-8";
      LC_PAPER = "ko_KR.UTF-8";
      LC_TELEPHONE = "ko_KR.UTF-8";
      LC_TIME = "ko_KR.UTF-8";
    };
  };

  # fonts = {
  #   packages = with pkgs; [
  #     noto-fonts-cjk-sans
  #     nanumfonts
  #   ];
  #   fontconfig.defaultFonts = {
  #     serif = ["Noto Serif CJK KR" "NanumMyeongjo"];
  #     sansSerif = ["Noto Sans CJK KR" "NanumGothic"];
  #     monospace = ["JetBrains Mono" "NanumGothicCoding"];
  #   };
  # };
}
