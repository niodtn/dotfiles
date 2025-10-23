{ lib, config, inputs, pkgs, ... }:
with lib;

let
  cfg = config.modules.gaming;
in
{
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  options.modules.gaming = {
    enable = mkEnableOption "gaming";
  };

  config = mkIf cfg.enable {
    environment.loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        gamemoderun gamescope -W 1920 -H 1080 -w 1280 -h 720 -f --rt --adaptive-sync --immediate-flips --fsr-sharpness 1 --steam -- steam -pipewire-dmabuf -bigpicture
      fi
    '';

    programs.gamemode.enable = true;

    # for gamescope
    programs.gamescope.enable = true;
    programs.gamescope.capSysNice = true;
    services.xserver.enable = false;
    programs.xwayland.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      platformOptimizations.enable = true;
      gamescopeSession.enable = true;
    };

    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      lowLatency = {
        enable = true;
        quantum = 64;
        rate = 48000;
      };
    };

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.xpadneo.enable = true;
  };
}
