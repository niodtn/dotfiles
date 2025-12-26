{ lib, config, flake, ... }:
with lib;

let
  starshipConfigPath = "${config.home.homeDirectory}/.config/starship/starship.toml";
  vscodeEnabled = config.programs.vscode.enable;
in
{
  programs.starship.enable = true;
  home.file.".config/starship".source = "${flake}/starship";

  home.sessionVariables.STARSHIP_CONFIG = mkForce starshipConfigPath;

  programs.vscode.profiles.default.userSettings = mkIf vscodeEnabled {
    "terminal.integrated.env.osx" = {
      "STARSHIP_CONFIG" = starshipConfigPath;
    };
  };
}
