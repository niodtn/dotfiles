{
  pkgs,
  flake,
  ...
}: {
  imports = [
    flake.homeModules.default
  ];

  features = {
    starship.enable = true;
    vscode.enable = true;
    vscode.nix.enable = true;
    vscode.minimal.enable = true;
  };

  home = {
    shell.enableBashIntegration = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#desktop";
      ll = "ls -al";
    };
  };
}
