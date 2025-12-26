{ pkgs, flake, ... }:

{
  imports = [
    flake.homeModules.home-shared
    # flake.homeModules.vscode
    ./hyprland.nix
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  home = {
    shell.enableBashIntegration = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#desktop";
      ll = "ls -al";
    };
  };
}
