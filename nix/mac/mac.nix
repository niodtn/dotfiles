# https://daiderd.com/nix-darwin/manual/index.html

{ config, pkgs, ... }:

{
  imports = [ ./pkgs.nix ];

  # For pkgs.nix
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nix-homebrew.enable = true;
  nix-homebrew.enableRosetta = true;
  nix-homebrew.autoMigrate = true;
  nix-homebrew.user = "20nabi";
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."20nabi" = import ./home.nix;

  security.pam.enableSudoTouchIdAuth = true;

  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
  system.defaults.dock.autohide = true;
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.wvous-bl-corner = 1;
  system.defaults.dock.wvous-br-corner = 1;
  system.defaults.dock.wvous-tl-corner = 1;
  system.defaults.dock.wvous-tr-corner = 1;

  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/finder.nix
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;

  system.defaults.trackpad.Clicking = true;

  nix.gc.automatic = true;
  system.defaults.WindowManager.EnableTiledWindowMargins = false;
  system.defaults.controlcenter.BatteryShowPercentage = true;
  programs.direnv.enable = true;
}
