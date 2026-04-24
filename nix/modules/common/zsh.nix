{
  self,
  inputs,
  ...
}: {
  flake.commonModules.zsh = {
    config,
    lib,
    pkgs,
    options,
    ...
  }: {
    config = lib.mkMerge [
      # common
      {
        programs.zsh.enable = true;
        users.users.${config.username}.shell = pkgs.zsh;

        # Home Manager Options
        home-manager.users.${config.username} = {
          programs.zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
          };
        };
      }
      # darwin
      (lib.optionalAttrs (options ? homebrew) {
        homebrew.enableZshIntegration = true;
      })
    ];
  };
}
