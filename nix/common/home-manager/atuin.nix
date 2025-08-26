{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    daemon.enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "0";
    };

    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
