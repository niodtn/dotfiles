{ config, pkgs, ... }:

{
  # Shell aliases
  home.shellAliases = {
    ".." = "cd ../";
    "..." = "cd ../../";
    c = "clear";
    ll = "ls -al";
    gbc = "git branch | grep -v main | xargs git branch -D && git fetch -p";
  };
}
