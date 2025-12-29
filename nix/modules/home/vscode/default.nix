{ lib, config, pkgs, ... }:
with lib;

let
  cfg = config.features.vscode;

  extensions = import ./extensions.nix { inherit pkgs; };
  userSettings = import ./user-settings.nix;
  keybindings = import ./keybindings.nix { inherit pkgs; };

in
{
  options.features.vscode = {
    enable = mkEnableOption "vscode feature";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;

      profiles.default = {
        extensions = extensions;
        userSettings = userSettings;
        keybindings = keybindings;
      };
    };
  };
}
