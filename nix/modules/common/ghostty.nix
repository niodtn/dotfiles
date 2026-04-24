{
  self,
  inputs,
  ...
}: {
  flake.commonModules.ghostty = {
    config,
    lib,
    options,
    pkgs,
    ...
  }: {
    config = {
      home-manager.users.${config.username}.programs.ghostty = lib.mkMerge [
        # common
        {
          enable = true;
          settings = {
            background-opacity = 0.9;
            background-blur-radius = 10;
          };
        }
        # linux
        (lib.optionalAttrs (options ? boot) {
          systemd.enable = true;
        })
        # darwin
        (lib.optionalAttrs (options ? homebrew) {
          package = pkgs.ghostty-bin;
          settings = {
            background = "000000";
            foreground = "ffffff";
            window-padding-x = 25;
            window-padding-balance = true;
            macos-titlebar-style = "tabs";
            # macos-icon = "blueprint";
            macos-secure-input-indication = false;
          };
        })
      ];
    };
  };
}
