{
  flake.aspects.programs.homeManager = {
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
}