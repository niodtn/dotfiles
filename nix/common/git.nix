{ config, pkgs, ... }:

{
  home-manager.users.niodtn = {
    programs.git = {
      enable = true;
      userName = "niodtn";
      userEmail = "ipete93@gmail.com";
    };
  };
}
