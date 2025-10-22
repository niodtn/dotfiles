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
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      platformOptimizations.enable = true;
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

    environment.systemPackages = [
      # pkgs.lutris
      pkgs.heroic
      pkgs.mangohud
    ];
  };
}
