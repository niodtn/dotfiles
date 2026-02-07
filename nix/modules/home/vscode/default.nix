{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.vscode;
  system = pkgs.stdenv.hostPlatform.system;
  marketplace = inputs.vscode-extensions.extensions.${system}.vscode-marketplace;
in {
  options.features.vscode = {
    enable = mkEnableOption "vscode feature";
  };

  imports = [
    ./themes.nix
    # features
    ./features/copilot.nix
    ./features/jupyter.nix
    ./features/markdown.nix
    ./features/minimal.nix
    ./features/nix.nix
    ./features/remote.nix
  ];

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;

      profiles.default = {
        keybindings = import ./keybindings.nix {inherit pkgs;};
        userSettings = {
          # Save and Formatting
          "files.autoSave" = "off";
          "editor.formatOnSave" = true;
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;

          # Terminal
          "terminal.integrated.enablePersistentSessions" = false;
          "terminal.integrated.persistentSessionReviveProcess" = "never";
          "terminal.integrated.hideOnStartup" = "always";
          "terminal.integrated.smoothScrolling" = true;

          # Editor - General
          "editor.bracketPairColorization.enabled" = true;
          "editor.minimap.enabled" = false;
          "editor.lineNumbers" = "interval";
          "editor.insertSpaces" = true; # Tab to spaces
          "editor.smoothScrolling" = true;
          "editor.stickyScroll.enabled" = false;
          "editor.copyWithSyntaxHighlighting" = false; # 복사 제대로
          "editor.detectIndentation" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "diffEditor.codeLens" = true;
          "diffEditor.ignoreTrimWhitespace" = false;

          # Editor - Cursor
          "editor.cursorBlinking" = "phase";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.cursorWidth" = 3;

          # File Tree & Explorer
          "workbench.tree.indent" = 20;
          "workbench.tree.renderIndentGuides" = "always";
          "workbench.tree.enableStickyScroll" = false;
          "workbench.tree.expandMode" = "doubleClick";
          "explorer.sortOrder" = "type";

          # Workbench - Layout & Navigation
          "workbench.list.smoothScrolling" = true;
          "workbench.navigationControl.enabled" = false;
          "workbench.layoutControl.enabled" = false;
          "workbench.startupEditor" = "none";

          # Window Management
          "window.restoreWindows" = "none";
          "window.commandCenter" = false;

          # etc
          "breadcrumbs.enabled" = false;
          "chat.commandCenter.enabled" = false;
          "chat.agentsControl.enabled" = false;
        };
        extensions = with marketplace; [
          esbenp.prettier-vscode
        ];
      };
    };
  };
}
