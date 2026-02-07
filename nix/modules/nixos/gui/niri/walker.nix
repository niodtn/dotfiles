{config, ...}: {
  home-manager.users.${config.username} = {
    services.walker = {
      enable = true;
      settings = {
        close_when_open = false;
        click_to_close = true;
      };
    };

    programs.niri.settings = {
      binds = {
        "Mod+Space".action.spawn = "walker";
      };

      spawn-at-startup = [
        {command = ["walker" "--gapplication-service"];}
      ];
    };
  };
}
