{ config, pkgs, ... }:

{
  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";
  programs.bash.completion.enable = true;

  programs.zsh.enable = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.enableCompletion = true;
  # programs.zsh.enableBashCompletion = true;
  programs.zsh.enableAutosuggestions = true;

  # programs.zsh.enableFzfCompletion = true;
  # programs.zsh.enableFzfGit = true;
  # programs.zsh.enableFzfHistory = true;

  programs.zsh.promptInit = ''
    autoload -U promptinit && promptinit && prompt suse && setopt prompt_sp
  '';
}
