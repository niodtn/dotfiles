let
  common = {
    config,
    pkgs,
    ...
  }: {
    home-manager.users.${config.host.userName} = {
      home.packages = [
        pkgs.nixd
        pkgs.nil
        pkgs.alejandra
      ];

      programs.zed-editor = {
        enable = true;
        extensions = ["nix"];

        userSettings = {
          disable_ai = true;

          lsp.nil.settings = {
            formatting.command = ["alejandra"];
            diagnostics.ignored = ["unused_binding"];
          };
        };
      };
    };
  };
in {
  flake.aspects = {aspects, ...}: {
    zed-editor = {
      includes = with aspects; [vcs];
      nixos = common;
      darwin = common;
    };
  };
}
