{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.features.atuin;
in {
  options.features.atuin = {
    enable = mkEnableOption "atuin feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      programs.atuin = {
        enable = true;
        daemon.enable = true;
        settings = {
          auto_sync = true;
          sync_frequency = "0";
          sync_address = "https://api.atuin.sh";
          style = "auto";
          invert = true;
        };
      };
    };
  };
}
