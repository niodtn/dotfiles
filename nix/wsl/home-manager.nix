{ config, pkgs, ... }:

{
  users.users.nixos.home = "/home/nixos";
  home-manager.users.nixos.home.homeDirectory = "/home/nixos";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nixos.home.stateVersion = "25.11";
    users.nixos.home.username = "nixos";
    backupFileExtension = "backup";
  };

  home-manager.users.nixos = {
    programs.home-manager.enable = true;

    imports = [
      ../common/home-manager/git.nix
    ];

    # Basic shell configuration
    programs.bash.enable = true;

    # Shell aliases
    home.shellAliases = {
      ".." = "cd ../";
      "..." = "cd ../../";
      c = "clear";
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/nix#wsl";
    };
  };
}
