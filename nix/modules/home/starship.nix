{ lib, config, flake, ... }:
with lib;

let
  cfg = config.features.starship;

  starshipConfigPath = "${config.home.homeDirectory}/.config/starship/starship.toml";
  vscodeEnabled = config.programs.vscode.enable;

in
{
  options.features.starship = {
    enable = mkEnableOption "starship feature";
  };

  config = mkIf cfg.enable {
    programs.starship.enable = true;
    home.file.".config/starship".source = "${flake}/starship";

    home.sessionVariables.STARSHIP_CONFIG = mkForce starshipConfigPath;

    # For VSCode
    programs.vscode.profiles.default.userSettings = mkIf vscodeEnabled {
      "terminal.integrated.env.osx" = {
        "STARSHIP_CONFIG" = starshipConfigPath;
      };
    };
  };
}
