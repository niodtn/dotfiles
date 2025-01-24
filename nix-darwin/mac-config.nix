# https://daiderd.com/nix-darwin/manual/index.html

{ config, pkgs, ... }:

{
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

  # Enable touch ID support for sudo.
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.WindowManager.EnableTiledWindowMargins = false;
  system.defaults.controlcenter.BatteryShowPercentage = true;
  nixpkgs.config.allowUnfree = true;
  nix.gc.automatic = true;

  programs.direnv.enable = true;
}
