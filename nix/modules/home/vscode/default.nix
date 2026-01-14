{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.vscode;
in {
  options.features.vscode = {
    enable = mkEnableOption "vscode feature";
  };

  imports = [
    ./features/copilot.nix
    ./features/jupyter.nix
    ./features/markdown.nix
    ./features/nix.nix
  ];

  config = mkIf cfg.enable (mkMerge [
    {
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

            # Editor - Cursor
            "editor.cursorBlinking" = "phase";
            "editor.cursorSmoothCaretAnimation" = "on";
            "editor.cursorWidth" = 3;

            # File Tree & Explorer
            "workbench.tree.indent" = 20;
            "workbench.tree.renderIndentGuides" = "always";
            "workbench.tree.enableStickyScroll" = false;
            "workbench.tree.expandMode" = "doubleClick";

            # Workbench - Layout & Navigation
            "workbench.list.smoothScrolling" = true;
            "workbench.navigationControl.enabled" = false;
            "workbench.layoutControl.enabled" = false;
            "workbench.startupEditor" = "none";
            "breadcrumbs.enabled" = false;
            "chat.commandCenter.enabled" = false;

            # Window Management
            "window.restoreWindows" = "none";
          };
          extensions = with pkgs.vscode-extensions; [
            esbenp.prettier-vscode

            # Remote Development
            # ms-vscode-remote.remote-containers
            # ms-vscode-remote.remote-wsl
            # ms-vscode-remote.remote-ssh
          ];
        };
      };
    }

    (import ./themes.nix {inherit pkgs;})
  ]);
}
