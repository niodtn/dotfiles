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
    sync.enable = mkEnableOption "atuin sync feature";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home-manager.users.${config.username} = {
        programs.atuin = {
          enable = true;
          settings = {
            style = "auto";
            invert = true;
          };
        };
      };
    }
    (mkIf cfg.sync.enable {
      home-manager.users.${config.username} = {
        programs.atuin = {
          daemon.enable = true;
          settings = {
            auto_sync = true;
            sync_frequency = "0";
            sync_address = "https://api.atuin.sh";
          };
        };
      };
    })
  ]);
}
