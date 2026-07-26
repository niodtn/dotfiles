{lib, ...}: let
  common = {
    config,
    pkgs,
    ...
  }: {
    home-manager.users.${config.host.userName} = lib.mkMerge [
      # Base
      {
        programs.zed-editor = {
          enable = true;

          userSettings = {
            format_on_save = "on";
            base_keymap = "VSCode";
            disable_ai = true;
            session.trust_all_worktrees = true;

            title_bar = {
              show_sign_in = false;
              show_user_picture = false;
              show_onboarding_banner = false;
            };

            git.inline_blame.show_commit_summary = true;
            project_panel.dock = "left";
          };
        };
      }

      # Nix
      {
        home.packages = [
          pkgs.nixd
          pkgs.nil
          pkgs.alejandra
        ];

        programs.zed-editor = {
          extensions = ["nix"];

          userSettings = {
            lsp.nil.settings = {
              formatting.command = ["alejandra"];
              diagnostics.ignored = ["unused_binding"];
            };
          };
        };
      }
    ];
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
