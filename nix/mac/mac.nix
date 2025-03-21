# https://daiderd.com/nix-darwin/manual/index.html

{ config, pkgs, ... }:

{
  imports = [ ./pkgs.nix ];

  nix.gc.automatic = true;

  # For pkgs.nix
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nix-homebrew.enable = true;
  nix-homebrew.enableRosetta = true;
  nix-homebrew.autoMigrate = true;
  nix-homebrew.user = "niodtn";
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";

  # Security
  security.pam.services.sudo_local.touchIdAuth = true;

  # Status Bar
  system.defaults.controlcenter.BatteryShowPercentage = true;
  system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;

  # Dock
  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
  system.defaults.dock.autohide = true;
  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.wvous-bl-corner = 1;
  system.defaults.dock.wvous-br-corner = 1;
  system.defaults.dock.wvous-tl-corner = 1;
  system.defaults.dock.wvous-tr-corner = 1;
  system.defaults.dock.mineffect = "scale";

  # Finder
  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/finder.nix
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.AppleShowAllExtensions = true;

  # Keyboard
  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
  system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

  # Trackpad
  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/trackpad.nix
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.trackpad.ActuationStrength = 0;
  system.defaults.trackpad.FirstClickThreshold = 0;
  system.defaults.trackpad.SecondClickThreshold = 0;

  # Window Manager
  system.defaults.WindowManager.EnableTiledWindowMargins = false;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;

  # Aliases
  environment.shellAliases.ls = "lsd";
  environment.shellAliases.cat = "bat";

  # Direnv
  programs.direnv.enable = true;

  # zsh
  programs.zsh.enable = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';
  programs.bash.completion.enable = true;

  # Vim
  # programs.vim.package = pkgs.neovim.override {
  #   configure = {
  #     packages.darwin.start = with pkgs.vimPlugins; [

  #     ];
  #   };
  # };
}
