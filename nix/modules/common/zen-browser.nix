{
  lib,
  config,
  pkgs,
  inputs,
  options,
  ...
}:
with lib; let
  cfg = config.features.zen-browser;
  nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
in {
  options.features.zen-browser = {
    enable = mkEnableOption "zen-browser feature";
  };

  config = mkIf cfg.enable (mkMerge [
    # common
    {
      home-manager.users.${config.username} = {
        imports = [inputs.zen-browser.homeModules.beta];
        programs.zen-browser = {
          enable = true;

          policies = {
            DisableAppUpdate = true;
            DontCheckDefaultBrowser = true;
            DisableTelemetry = true;
            NoDefaultBookmarks = true;
            DisableFirefoxAccounts = true;
            OfferToSaveLogins = false;

            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;

            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };
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
              "zen.view.compact.enable-at-startup" = true;
              "zen.view.compact.hide-tabbar" = true;
              "zen.view.compact.hide-toolbar" = mkDefault true;
              "browser.aboutConfig.showWarning" = false;
              "browser.tabs.warnOnClose" = false;
            };
            search = {
              force = true;
              default = "google";
              engines = {
                "Nix Pkgs" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "type";
                          value = "packages";
                        }
                        {
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = nixSnowflakeIcon;
                  definedAliases = ["pkgs"];
                };

                "Home Manager Options" = {
                  urls = [
                    {
                      template = "https://home-manager-options.extranix.com/";
                      params = [
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                        {
                          name = "release";
                          value = "master";
                        }
                      ];
                    }
                  ];
                  icon = nixSnowflakeIcon;
                  definedAliases = ["home"];
                };
              };
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
          profiles.default = {
            search.engines = {
              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = nixSnowflakeIcon;
                definedAliases = ["nix"];
              };
            };
          };
        };
      };
    })
    # darwin
    (optionalAttrs (options ? homebrew) {
      home-manager.users.${config.username} = {
        programs.zen-browser = {
          darwinDefaultsId = "app.zen-browser.zen";
          profiles.default = {
            settings = {
              "zen.view.compact.hide-toolbar" = false;
            };
            search.engines = {
              "Nix Darwin Options" = {
                urls = [
                  {
                    template = "https://mynixos.com/search";
                    params = [
                      {
                        name = "q";
                        value = "nix-darwin%2Foption+{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = nixSnowflakeIcon;
                definedAliases = ["nix"];
              };
            };
          };
        };
      };
    })
  ]);
}
