{
  lib,
  config,
  flake,
  ...
}:
with lib; let
  feat = config.features;
  cfg = feat.starship;
  starshipConfigPath = "${config.users.users.${config.username}.home}/.config/starship/starship.toml";
in {
  options.features.starship = {
    enable = mkEnableOption "starship feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      programs.starship.enable = true;
      home.file.".config/starship".source = "${flake}/starship";

      home.sessionVariables.STARSHIP_CONFIG = mkForce starshipConfigPath;

      # For VSCode
      programs.vscode.profiles.default.userSettings = mkIf feat.vscode.enable {
        "terminal.integrated.env.osx" = {
          "STARSHIP_CONFIG" = starshipConfigPath;
        };
      };
    };
  };
}
