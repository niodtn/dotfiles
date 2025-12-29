{ inputs, ... }:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  config = {
    nix-homebrew.enable = true;
    nix-homebrew.enableRosetta = true;
    nix-homebrew.autoMigrate = true;

    homebrew.enable = true;
    homebrew.onActivation.cleanup = "zap";
    homebrew.onActivation.upgrade = true;

    homebrew.brews = [ "mas" ];
  };
}
