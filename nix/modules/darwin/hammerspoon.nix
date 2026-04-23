{
  lib,
  config,
  flake,
  ...
}:
with lib; let
  cfg = config.features.hammerspoon;
  username = config.username;
in {
  options.features.hammerspoon = {
    enable = mkEnableOption "hammerspoon feature";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["hammerspoon"];

    # Home Manager Options
    home-manager.users.${username} = {lib, ...}: {
      home.activation.linkHammerspoon = lib.hm.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD rm -rf $HOME/.hammerspoon
        $DRY_RUN_CMD ln -sfn $HOME/dotfiles/hammerspoon $HOME/.hammerspoon
      '';
    };
  };
}
