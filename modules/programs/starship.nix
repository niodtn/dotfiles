let
  common = {config, ...}: {
    home-manager.users.${config.host.userName} = {
      programs.starship = {
        enable = true;

        settings = {
          add_newline = false;
          character.format = "❯ ";

          line_break.disabled = true;
          git_status.disabled = true;
          package.disabled = true;
          python.disabled = true;
        };
      };
    };
  };
in {
  flake.aspects.starship = {
    nixos = common;
    darwin = common;
  };
}
