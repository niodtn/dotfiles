{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.zsh;
  username = config.username;
in {
  options.features.zsh = {
    enable = mkEnableOption "zsh feature";
  };
  config = mkIf cfg.enable {
    programs.zsh.enable = true;
    users.users.${username}.shell = pkgs.zsh;

    # Home Manager Options
    home-manager.users.${username} = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
      };
    };
  };
}
