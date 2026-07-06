{pkgs, ...}: let
  kanataConfig = pkgs.writeText "kanata.cfg" ''
    (defsrc rmet)
    (defvar tap-time 200 hold-time 200)
    (defalias rmet-mod (tap-hold $tap-time $hold-time f18 rmet))
    (deflayer default @rmet-mod)
  '';
in {
  environment.systemPackages = [
    pkgs.kanata
    pkgs.karabiner-dk
  ];

  # TODO: fix
  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
      # 60: Select the previous input source
      "60" = {
        enabled = true;
        value = {
          parameters = [
            65535
            119 # KeyCode: F18
            0
          ];
          type = "standard";
        };
      };
    };
  };

  launchd = {
    daemons = {
      kanata = {
        serviceConfig = {
          ProgramArguments = [
            "${pkgs.kanata}/bin/kanata"
            "--cfg"
            "${kanataConfig}"
          ];
          KeepAlive = true;
          RunAtLoad = true;
          StandardOutPath = "/var/log/kanata.out.log";
          StandardErrorPath = "/var/log/kanata.err.log";
        };
      };

      karabiner-daemon = {
        serviceConfig = {
          ProgramArguments = [
            "${pkgs.karabiner-dk}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"
          ];
          KeepAlive = true;
          RunAtLoad = true;
          StandardOutPath = "/var/log/karabiner-daemon.out.log";
          StandardErrorPath = "/var/log/karabiner-daemon.err.log";
        };
      };
    };

    user.agents.activate-karabiner-driver = {
      serviceConfig = {
        ProgramArguments = [
          "${pkgs.karabiner-dk}/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager"
          "activate"
        ];
        RunAtLoad = true;
        StandardOutPath = "/var/log/karabiner-activate.out.log";
        StandardErrorPath = "/var/log/karabiner-activate.err.log";
      };
    };
  };
}
