{ pkgs, flake, ... }:

{
  imports = [
    flake.homeModules.home-shared
    flake.homeModules.vscode
  ];

  # Basic shell configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  # Shell aliases
  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/nix#desktop";
  };
}
