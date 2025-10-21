{ pkgs, ... }:

{
  home.shellAliases = {
    ".." = "cd ../";
    "..." = "cd ../../";
    c = "clear";
    gbc = "git branch | grep -v main | xargs git branch -D && git fetch -p";
    gpod = "git push origin --delete";
    gms = "git merge --squash";
  };

  programs.git = {
    enable = true;
    settings.user.name = "niodtn";
    settings.user.email = "ipete93@gmail.com";
  };

  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "0";
    };
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  home.stateVersion = "25.11";
}
