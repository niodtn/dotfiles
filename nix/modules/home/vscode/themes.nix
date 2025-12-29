{ pkgs, ... }:

{
  home.packages = [ pkgs.nerd-fonts.d2coding ];

  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      sdras.night-owl # White Theme
      zhuangtongfa.material-theme # Dark Theme
      pkief.material-icon-theme # Icon
    ];

    userSettings = {
      # Fonts
      "editor.fontFamily" = "D2CodingLigature Nerd Font";
      "terminal.integrated.fontFamily" = "D2CodingLigature Nerd Font";
      "editor.fontSize" = 16;
      "terminal.integrated.fontSize" = 14;
      "editor.fontLigatures" = true;

      # Themes
      "workbench.colorTheme" = "Night Owl Light";
      "workbench.iconTheme" = "material-icon-theme";
      "window.autoDetectColorScheme" = true;
      "workbench.preferredLightColorTheme" = "Night Owl Light";
      "workbench.preferredDarkColorTheme" = "One Dark Pro Flat";
    };
  };
}
