{ flake, pkgs, ... }:

{
  imports = [
    flake.homeModules.default
  ];

  features = {
    direnv.enable = true;
    python.enable = true;
    starship.enable = true;
    vscode.enable = true;
    vscode.markdown.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  home = {
    shell.enableZshIntegration = true;
    shellAliases = {
      rebuild = "sudo darwin-rebuild switch --flake ~/dotfiles#mac";
      ls = "lsd";
      ll = "lsd -al";
      cat = "bat";
    };

    packages = with pkgs; [
      lsd # `ls` command
      bat # `cat` command
    ];
  };

  # targets.darwin.copyApps.enableChecks = false;
}
