{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        esbenp.prettier-vscode

        # Themes
        sdras.night-owl # White Theme
        zhuangtongfa.material-theme # Dark Theme
        pkief.material-icon-theme # Icon

        # Remote Development
        ms-vscode-remote.remote-containers

        # Copilot
        github.copilot
        github.copilot-chat

        # Nix
        jnoortheen.nix-ide

        # Python
        charliermarsh.ruff
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
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

        # Python
          "[python]" = {
            "editor.codeActionsOnSave" = {
              "source.organizeImports" = "explicit";
              "source.fixAll" = "explicit";
            };
            "editor.defaultFormatter" = "charliermarsh.ruff";
          };
      };
      keybindings = [
        {
          key = "cmd+;";
          command = "workbench.action.toggleSidebarVisibility";
        }
        {
          key = "cmd+b"; # Remove Default
          command = "-workbench.action.toggleSidebarVisibility";
        }
        {
          key = "cmd+'";
          command = "workbench.action.toggleAuxiliaryBar";
        }
        {
          key = "alt+cmd+b"; # Remove Default
          command = "-workbench.action.toggleAuxiliaryBar";
        }
        {
          key = "cmd+p";
          command = "workbench.action.showCommands";
        }
        {
          key = "shift+cmd+p"; # Remove Default
          command = "-workbench.action.showCommands";
        }
      ];
    };
  };
}
