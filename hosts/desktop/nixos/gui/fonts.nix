{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      pretendard
      pretendard-dynamic
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
}
