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
    imports = [
      ../common/home-manager/defaults.nix
    ];

    # Basic shell configuration
    programs.bash = {
      enable = true;
      enableCompletion = true;
    };

    # For atuin with Visual Studio Code - Remote SSH
    programs.bash.initExtra = ''
      export XDG_RUNTIME_DIR="/run/user/$(id -u)"
    '';

    # Shell aliases
    home.shellAliases = {
      ll = "ls -al";
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/nix#wsl";
    };
  };
}
