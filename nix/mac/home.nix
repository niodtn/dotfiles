{ config, pkgs, ... }:

{
  home.username = "20nabi";
  home.homeDirectory = "/Users/20nabi";
  home.stateVersion = "23.05";

  home.file = {
    # ".zshrc".source = ~/dotfile/zshrc/.zshrc;
  };

  programs.home-manager.enable = true;
  programs.zsh.enable = true;
}
