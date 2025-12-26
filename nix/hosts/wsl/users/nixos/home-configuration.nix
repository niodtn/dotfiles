{ flake, ... }:

{
  imports = [ flake.homeModules.home-shared ];

  # Basic shell configuration
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  # Shell aliases
  home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#wsl";
    ll = "ls -al";
  };

  # For atuin with Visual Studio Code - Remote SSH
  programs.bash.initExtra = ''
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  '';
}
