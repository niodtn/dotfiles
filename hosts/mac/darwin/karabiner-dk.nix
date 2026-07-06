{pkgs, ...}: let
  parentAppDir = "/Applications/.Nix-Karabiner-DriverKit";
  managerApp = ".Karabiner-VirtualHIDDevice-Manager.app";
in {
  environment.systemPackages = [pkgs.karabiner-dk];

  system.activationScripts.preActivation.text = ''
    mkdir -p ${parentAppDir}
    ditto --norsrc ${pkgs.karabiner-dk}/Applications/.Karabiner-VirtualHIDDevice-Manager.app ${parentAppDir}/.Karabiner-VirtualHIDDevice-Manager.app
  '';

  launchd.agents.karabiner_dk_activation = {
    script = ''
      exec ${parentAppDir}/${managerApp}/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
    '';
    serviceConfig = {
      Label = "org.nixos.karabiner_driverkit_activation";
      RunAtLoad = true;
      LaunchOnlyOnce = true;
    };
  };

  launchd.daemons.karabiner_dk_daemon = {
    script = ''
      exec "${pkgs.karabiner-dk}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"
    '';
    serviceConfig = {
      ProcessType = "Interactive";
      Label = "org.nixos.karabiner_driverkit_daemon";
      KeepAlive = true;
      RunAtLoad = true;
    };
  };
}
