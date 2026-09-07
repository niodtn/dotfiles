{
  lib,
  config,
  ...
}: let
  cfg = config.etc.fonts;
in {
  options = {
    etc.fonts = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.desktop.nixos = {pkgs, ...}: {
      fonts = {
        packages = with pkgs; [
          pretendard
          noto-fonts-cjk-sans
          d2coding
        ];

        fontconfig = {
          enable = true;

          subpixel.lcdfilter = "default";
          subpixel.rgba = "rgb";
          hinting.enable = true;
          hinting.style = "slight";

          defaultFonts = {
            sansSerif = ["Pretendard" "Noto Sans CJK KR"];
            serif = ["Noto Serif CJK KR"];
            monospace = ["D2Coding"];
          };
        };
      };
    };
  };
}
