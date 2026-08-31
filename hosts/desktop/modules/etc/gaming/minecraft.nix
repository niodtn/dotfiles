{
  lib,
  config,
  ...
}: let
  cfg = config.gaming.minecraft;
in {
  options = {
    gaming.minecraft = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.host-desktop.nixos = {config, ...}: {
      home-manager.users.${config.host.userName} = {pkgs, ...}: {
        home.packages = with pkgs; [
          prismlauncher
        ];
      };
    };
  };
}
