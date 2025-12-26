{ flake, pkgs, ... }:

{
  imports = [
    flake.homeModules.home-shared
    flake.homeModules.vscode
  ];

  # Basic shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  home.packages = with pkgs; [
    lsd # `ls` command
    bat # `cat` command
  ];

  # Shell aliases
  home.shellAliases = {
    rebuild = "sudo darwin-rebuild switch --flake ~/dotfiles#mac";
    ls = "lsd";
    ll = "lsd -al";
    cat = "bat";
  };

  # # Direnv
  # programs.direnv = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  # targets.darwin.copyApps.enableChecks = false;
}
