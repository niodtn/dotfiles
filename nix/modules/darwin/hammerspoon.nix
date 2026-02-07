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
    home-manager.users.${username}.home.file.".hammerspoon" = {
      source = "${flake}/hammerspoon";
      recursive = true;
    };
  };
}
