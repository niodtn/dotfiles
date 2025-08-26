{ config, pkgs, ... }:

{
  imports = [ ../common/home-manager.nix ];

  home-manager.users.nixos.home = {
    stateVersion = "25.11";
    username = "nixos";
    homeDirectory = "/home/nixos";
  };

  # specific settings
  home-manager.users.nixos = {
    programs.home-manager.enable = true;

    imports = [
      ../common/home-manager/aliases.nix
      ../common/home-manager/git.nix
    ];

    # Basic shell configuration
    programs.bash.enable = true;

    # Shell aliases
    home.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/nix#wsl";
    };
  };
}
