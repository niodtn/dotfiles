{lib, ...}: let
  mkLocked = value: {
    Value = value;
    Status = "locked";
  };

  policies = lib.mkMerge [
    # Base
    {
      DisableAppUpdate = true;
      DisableFirefoxAccounts = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;

      Preferences = {
        "browser.aboutConfig.showWarning" = mkLocked false;
        "browser.tabs.warnOnClose" = mkLocked false;
        "browser.warnOnQuitShortcut" = mkLocked false;

        "browser.ctrlTab.sortByRecentlyUsed" = mkLocked true;
      };
    }

    # Password & Autofill
    {
      PasswordManagerEnabled = false;
      OfferToSaveLogins = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
    }

    # === Extensions ===

    # uBlock Origin
    {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = {
            advancedUserEnabled = true;
            cloudStorageEnabled = false;
          };
        };
      };
    }

    # Tampermonkey
    {
      ExtensionSettings = {
        "firefox@tampermonkey.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    }

    # TWP
    {
      ExtensionSettings = {
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    }

    # 1Password
    {
      ExtensionSettings = {
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4875695/1password_x_password_manager-8.12.26.40.xpi";
          installation_mode = "force_installed";
        };
      };
    }
  ];

  common = {config, ...}: {
    home-manager.users.${config.host.userName} = {
      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;

        inherit policies;
      };
    };
  };
in {
  flake.aspects.zen-browser = {
    nixos = lib.mkMerge [
      common
      ({
        config,
        pkgs,
        ...
      }: {
        home-manager.users.${config.host.userName} = {
          programs.zen-browser = {
            nativeMessagingHosts = [
              pkgs.firefoxpwa
            ];
          };
        };
      })
    ];
    darwin = lib.mkMerge [
      common
      ({config, ...}: {
        home-manager.users.${config.host.userName} = {
          programs.zen-browser = {
            darwinDefaultsId = "app.zen-browser.zen";
          };
        };
      })
    ];
  };
}
