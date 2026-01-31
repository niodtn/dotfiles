{...}: {
  imports = [
    ./atuin.nix
    ./direnv.nix
    ./jujutsu.nix
    ./python.nix
    ./starship.nix
  ];

  features = {
    atuin.enable = true;
    jujutsu.enable = true;
  };

  home.shellAliases = {
    ".." = "cd ../";
    "..." = "cd ../../";
    c = "clear";
  };

  home.stateVersion = "26.05";
}
