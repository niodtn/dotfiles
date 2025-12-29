{ ... }:

{
  imports = [
    ./vscode
    ./direnv.nix
    ./git.nix
    ./jujutsu.nix
    ./python.nix
    ./starship.nix
  ];

  features = {
    git.enable = true;
    jujutsu.enable = true;
  };

  home.shellAliases = {
    ".." = "cd ../";
    "..." = "cd ../../";
    c = "clear";
  };

  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "0";
      style = "auto";
      invert = true;
    };
  };

  home.stateVersion = "26.05";
}
