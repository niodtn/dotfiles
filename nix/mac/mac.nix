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
  nix-homebrew.user = "niodtn";
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";

  programs.direnv.enable = true;

  security.pam.enableSudoTouchIdAuth = true;

  # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/NSGlobalDomain.nix
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

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

  # Aliases
  environment.shellAliases.ls = "lsd";
  environment.shellAliases.cat = "bat";

  # Vim
  # programs.vim.package = pkgs.neovim.override {
  #   configure = {
  #     packages.darwin.start = with pkgs.vimPlugins; [

  #     ];
  #   };
  # };

  system.defaults.trackpad.Clicking = true;

  nix.gc.automatic = true;
  system.defaults.WindowManager.EnableTiledWindowMargins = false;
  system.defaults.controlcenter.BatteryShowPercentage = true;
}
