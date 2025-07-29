{ config, pkgs, ... }:

{
    home-manager.users.niodtn = {
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.suggestSmartCommit" = false;
    }
}