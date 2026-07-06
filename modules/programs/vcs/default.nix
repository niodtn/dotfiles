let
  name = "niodtn";
  email = "ipegte93@gmail.com";

  common = {config, ...}: {
    home-manager.users.${config.host.userName}.programs = {
      git.settings.user = {inherit name email;};
      jujutsu.settings.user = {inherit name email;};
    };
  };
in {
  flake.aspects = {aspects, ...}: {
    vcs = {
      includes = with aspects; [git jujutsu];
      nixos = common;
      darwin = common;
    };
  };
}
