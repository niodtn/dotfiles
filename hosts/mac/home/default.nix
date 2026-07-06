{
  config,
  lib,
  ...
}: {
  home-manager.users.${config.host.userName} = {
    home.stateVersion = "26.11";

    # services.syncthing = {
    #   settings.folders."Downloads" = {
    #     id = "downloads";
    #     path = "${hm.config.home.homeDirectory}/Downloads";
    #   };
    # };

    programs.zed-editor = lib.mkMerge [
      # Common
      {
        enable = true;

        userSettings = {
          disable_ai = true;
        };
      }

      # Nix LSP
      {
        extensions = ["nix"];
        userSettings.lsp = {
          nil.settings = {
            formatting.command = ["alejandra"];
            diagnostics.ignored = ["unused_binding"];
          };
        };
      }
    ];
  };
}
