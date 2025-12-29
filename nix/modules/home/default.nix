{ ... }:

{
  imports = [
    ./vscode
    ./atuin.nix
    ./direnv.nix
    ./git.nix
    ./jujutsu.nix
    ./python.nix
    ./starship.nix
  ];

  features = {
    atuin.enable = true;
    git.enable = true;
    jujutsu.enable = true;
  };

  home.shellAliases = {
    ".." = "cd ../";
    "..." = "cd ../../";
    c = "clear";
  };

  home.stateVersion = "26.05";
}
