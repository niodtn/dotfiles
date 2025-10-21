{ pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  modifierKey = if isDarwin then "cmd" else "ctrl";
in
[
  {
    key = "${modifierKey}+b"; # Remove Default
    command = "-workbench.action.toggleSidebarVisibility";
  }
  {
    key = "${modifierKey}+;";
    command = "workbench.action.toggleSidebarVisibility";
  }

  {
    key = "alt+${modifierKey}+b"; # Remove Default
    command = "-workbench.action.toggleAuxiliaryBar";
  }
  {
    key = "${modifierKey}+'";
    command = "workbench.action.toggleAuxiliaryBar";
  }

  {
    key = "shift+${modifierKey}+p"; # Remove Default
    command = "-workbench.action.showCommands";
  }
  {
    key = "${modifierKey}+p";
    command = "workbench.action.showCommands";
  }
]
