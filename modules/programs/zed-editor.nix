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
          git.inline_blame.enabled = false;

          title_bar = {
            show_sign_in = false;
            show_user_picture = false;
            show_onboarding_banner = false;
          };

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
