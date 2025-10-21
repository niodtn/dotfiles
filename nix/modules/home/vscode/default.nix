{ pkgs, ... }:

let
  extensions = import ./extensions.nix { inherit pkgs; };
  userSettings = import ./user-settings.nix;
  keybindings = import ./keybindings.nix { inherit pkgs; };
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = extensions;
      userSettings = userSettings;
      keybindings = keybindings;
    };
  };
}
