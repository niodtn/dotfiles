# https://wiki.nixos.org/wiki/Steam#Gamescope_Compositor_/_%22Boot_to_Steam_Deck%22
{ lib, config, pkgs, ... }:
with lib;

let
  cfg = config.modules.steamDeck;
in
{
  options.modules.steamDeck = {
    enable = mkEnableOption "steam deck mode";
  };

  config = mkIf cfg.enable {
    programs.gamescope.capSysNice = true;
    programs.steam.gamescopeSession.enable = true;

    services.xserver.enable = false; # Assuming no other Xserver needed
    programs.xwayland.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # command = "${pkgs.gamescope}/bin/gamescope -W 1920 -H 1080 -f -e --xwayland-count 2 --hdr-enabled --hdr-itm-enabled -- steam -pipewire-dmabuf -gamepadui -steamdeck -steamos3";
          command = "${pkgs.gamescope}/bin/gamescope -W 1920 -H 1080 -f -e --xwayland-count 2 -- steam -pipewire-dmabuf -steamos3";
          user = "nixos";
        };
      };
    };
  };
}
