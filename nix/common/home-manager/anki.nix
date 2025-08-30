{ config, pkgs, ... }:

{
  program.anki = {
    enable = true;
    addons = [ ]; # Add Ankiconnect, FSRS Helper, ...
  };
}
