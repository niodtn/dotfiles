{
  pkgs,
  flake,
  ...
}: {
  imports = [
    flake.homeModules.default
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
