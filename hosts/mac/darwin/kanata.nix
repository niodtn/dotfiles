{pkgs, ...}: let
  kanataDir = "/Library/Application Support/org.nixos.kanata";
  kanataBin = "${kanataDir}/kanata";

  kanataConfig = pkgs.writeText "kanata.kbd" ''
    (defcfg process-unmapped-keys yes)

    (defsrc
      rmet
      fn
      f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12
    )

    (defvar tap-time 200 hold-time 200)

    (defalias
      rmet-mod (tap-hold $tap-time $hold-time f18 rmet)
      fn-layer (layer-toggle media-layer)
    )

    (deflayer default
      @rmet-mod
      @fn-layer
      f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12
    )

    (deflayer media-layer
      -
      -
      brdn brup XX XX XX XX XX XX XX mute vold volu
    )
  '';
in {
  environment.systemPackages = [pkgs.kanata];

  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
      # 60: Select the previous input source
      "60" = {
        enabled = true;
        value = {
          parameters = [
            65535
            79 # F18 KeyCode
            0
          ];
          type = "standard";
        };
      };
      # 61: Select next source in Input menu
      "61" = {
        enabled = false;
      };
    };
  };

  system.activationScripts.postActivation.text = ''
    mkdir -p "${kanataDir}"

    old_hash=""
    if [ -f "${kanataBin}" ]; then
      old_hash=$(shasum -a 256 "${kanataBin}" | cut -d' ' -f1)
    fi

    cp -f "${pkgs.kanata}/bin/kanata" "${kanataBin}"
    chmod +x "${kanataBin}"

    new_hash=$(shasum -a 256 "${kanataBin}" | cut -d' ' -f1)
    if [ "$old_hash" != "$new_hash" ]; then
      tccutil reset Accessibility "${kanataBin}" 2>/dev/null || true
      sudo launchctl kickstart -k system/org.nixos.kanata 2>/dev/null || true
    fi
  '';

  launchd.daemons.kanata = {
    serviceConfig = {
      Program = kanataBin;
      ProgramArguments = [
        kanataBin
        "--no-wait"
        "--cfg"
        "${kanataConfig}"
      ];
      Label = "org.nixos.kanata";
      ProcessType = "Interactive";
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/var/log/kanata.log";
      StandardErrorPath = "/var/log/kanata.log";
    };
  };
}
