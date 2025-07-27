{ config, pkgs, ... }:

{
  home-manager.users.niodtn = {
    programs.vscode = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          esbenp.prettier-vscode

          # Themes
          sdras.night-owl # White Theme
          zhuangtongfa.material-theme # Dark Theme
          pkief.material-icon-theme # Icon

          # Remote Development
          ms-vscode-remote.vscode-remote-extensionpack
          ms-vscode-remote.remote-containers
        ];

        userSettings = {
          # Fonts
          "editor.fontFamily" = "Sarasa Mono K";
          "terminal.integrated.fontFamily" = "Sarasa Mono K Nerd Font";
          "editor.fontSize" = 16;
          "terminal.integrated.fontSize" = 14;
          "editor.fontLigatures" = false;

          # Themes
          "workbench.colorTheme" = "Night Owl Light";
          "workbench.iconTheme" = "material-icon-theme";
          "window.autoDetectColorScheme" = true;
          "workbench.preferredLightColorTheme" = "Night Owl Light";
          "workbench.preferredDarkColorTheme" = "One Dark Pro Flat";

          # Git
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "git.suggestSmartCommit" = false;

          # Save and Formatting
          "files.autoSave" = "off";
          "editor.formatOnSave" = true;
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;

          # Dev Container with Finch
          "dev.containers.dockerPath" = "finch";
          "dev.containers.dockerComposePath" = "finch compose";

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
      };
    };
  };
}
