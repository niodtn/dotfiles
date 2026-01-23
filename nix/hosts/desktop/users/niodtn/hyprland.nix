{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    plugins = with pkgs.hyprlandPlugins; [
      hyprbars
    ];
    settings = {
      "$fileManager" = "dolphin";

      bind = [
        "$mainMod, E, exec, $fileManager"
      ];

      "plugin:hyprbars:bar_height" = 20;
      "plugin:hyprbars:hyprbars-button:0" = "rgb(ff4040), 10, 󰖭, hyprctl dispatch killactive";
      "plugin:hyprbars:hyprbars-button:1" = "rgb(eeee11), 10, , hyprctl dispatch fullscreen 1";
      "plugin:hyprbars:on_double_click" = "hyprctl dispatch fullscreen 1";
    };
  };
}
