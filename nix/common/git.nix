{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "niodtn";
    userEmail = "ipete93@gmail.com";
  };
}
