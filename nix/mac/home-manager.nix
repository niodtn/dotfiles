{ config, pkgs, ... }:

{
  users.users.niodtn.home = "/Users/niodtn";
  home-manager.users.niodtn.home.homeDirectory = "/Users/niodtn";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.niodtn.home.stateVersion = "25.11";
    users.niodtn.home.username = "niodtn";
    backupFileExtension = "backup";
  };

  home-manager.users.niodtn = {
    programs.home-manager.enable = true;

    imports = [
      ../common/home-manager/aliases.nix
      ../common/home-manager/git.nix
      ../common/home-manager/vscode.nix
    ];

    # Basic shell configuration
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    # Direnv
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    # Add any user-specific packages here
    home.packages = with pkgs; [
      # Add packages that should be available to the user
    ];

    # Shell aliases
    home.shellAliases = {
      ls = "lsd";
      ll = "lsd -al";
      cat = "bat";
      rebuild = "sudo darwin-rebuild switch --flake ~/dotfiles/nix#mac";
      myip = "curl http://ipecho.net/plain; echo";
    };
  };
}
