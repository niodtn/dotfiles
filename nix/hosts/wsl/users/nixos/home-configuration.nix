{flake, ...}: {
  imports = [flake.homeModules.default];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  home = {
    shell.enableBashIntegration = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#wsl";
    };
  };

  # For atuin with Visual Studio Code - Remote SSH
  programs.bash.initExtra = ''
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
  '';
}
