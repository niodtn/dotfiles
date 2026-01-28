{
  config,
  pkgs,
  ...
}: let
  username = config.username;
in {
  home-manager.users.${username}.wayland.windowManager.hyprland = {
    plugins = with pkgs.hyprlandPlugins; [
      hyprbars
    ];
    settings.plugin.hyprbars = {
      "bar_height" = 30;
      "bar_color" = "rgb(111111)";
      "bar_padding" = 15;
      "bar_button_padding" = 5;

      "bar_title_enabled" = true;
      "bar_text_size" = 10;
      "bar_text_align" = "center";
      "bar_buttons_alignment" = "left";

      "hyprbars-button" = [
        "rgb(ff4040), 10, , hyprctl dispatch killactive"
        "rgb(eeee11), 10, , hyprctl dispatch fullscreen 1"
      ];
      "on_double_click" = "hyprctl dispatch fullscreen 1";
    };
  };
}
