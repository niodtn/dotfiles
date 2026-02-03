{
  lib,
  config,
  options,
  perSystem,
  ...
}:
with lib; let
  cfg = config.features.vesktop;
in {
  options.features.vesktop = {
    enable = mkEnableOption "vesktop feature";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home-manager.users.${config.username}.programs.vesktop = {
        enable = true;
        settings = {
          checkUpdates = false;
          hardwareAcceleration = true;
        };
        vencord.settings = {
          autoUpdate = false;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          plugins = {
            FakeNitro.enabled = true;
            NoF1.enabled = true;
            Translate.enabled = true;
            SilentTyping.enabled = true;
            MessageLogger = {
              enabled = true;
              ignoreSelf = true;
            };
          };
        };
      };
    }
    # linux
    (optionalAttrs (options ? boot) {
      home-manager.users.${config.username}.programs.vesktop = {
        vencord.useSystem = true;
      };
    })
    # Darwin
    (optionalAttrs (options ? homebrew) {
      home-manager.users.${config.username}.programs.vesktop = {
        package = perSystem.self.vesktop-bin;
      };
    })
  ]);
}
