{ lib, config, pkgs, ... }:
with lib;

let
  cfg = config.modules.reaper;
in
{
  options.modules.reaper = { enable = mkEnableOption "reaper"; };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      reaper
      reaper-sws-extension
      reaper-reapack-extension
    ];
  };
}
