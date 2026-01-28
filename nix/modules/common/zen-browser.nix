{
  lib,
  config,
  inputs,
  pkgs,
  options,
  ...
}:
with lib; let
  cfg = config.features.zen-browser;
in {
  options.features.zen-browser = {
    enable = mkEnableOption "zen-browser feature";
  };

  # imports = [inputs.zen-browser.homeModules.twilight];

  config = mkIf cfg.enable (mkMerge [
    # common
    {
      home-manager.users.${config.username} = {
        imports = [inputs.zen-browser.homeModules.twilight];
        programs.zen-browser = {
          enable = true;

          policies = {
            DisableAppUpdate = true;
            DontCheckDefaultBrowser = true;
            DisableTelemetry = true;
            NoDefaultBookmarks = true;

            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
          };

          profiles.default = {
            id = 0;
            extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
              ublock-origin
              bitwarden
            ];
            settings = {
              "zen.welcome-screen.seen" = true;
              "zen.workspaces.natural-scroll" = true;
            };
          };
        };
      };
    }
    # linux
    (optionalAttrs (options ? boot) {
      home-manager.users.${config.username} = {
        programs.zen-browser = {
          nativeMessagingHosts = [pkgs.firefoxpwa];
        };
      };
    })
    # darwin
    (optionalAttrs (options ? homebrew) {
      home-manager.users.${config.username} = {
        programs.zen-browser = {
          darwinDefaultsId = "app.zen-browser.zen";
        };
      };
    })
  ]);
}
