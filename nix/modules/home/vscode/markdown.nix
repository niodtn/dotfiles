{ pkgs, ... }:

{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
    ];

    userSettings = {
      "markdown.preview.scrollEditorWithPreview" = true;
      "markdown.preview.scrollPreviewWithEditor" = true;
      "[markdown]" = {
        "editor.formatOnSave" = true;
        "editor.wordWrap" = "on";
        "editor.quickSuggestions" = {
          "comments" = "on";
          "strings" = "on";
          "other" = "on";
        };
      };
    };
  };
}
