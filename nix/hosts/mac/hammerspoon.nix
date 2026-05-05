{config, ...}: {
  homebrew.casks = ["hammerspoon"];

  home-manager.users.${config.username} = {lib, ...}: {
    home.activation.linkHammerspoon = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD rm -rf $HOME/.hammerspoon
      $DRY_RUN_CMD ln -sfn $HOME/dotfiles/hammerspoon $HOME/.hammerspoon
    '';
  };
}
