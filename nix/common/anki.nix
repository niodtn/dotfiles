{ config, pkgs, ... }:

{
  home-manager.users.niodtn = {
    program.anki = {
        enable = true;
        addons = [ ]; # Add Ankiconnect, FSRS Helper, ...
    };
  };
}
