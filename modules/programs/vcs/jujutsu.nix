let
  common = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = [pkgs.jjui];

    home-manager.users.${config.host.userName}.programs = {
      jujutsu = {
        enable = true;
        settings = {
          ui.default-commnad = "log";
          revset-aliases."immutable_heads()" = "trunk() | tags()";
        };
      };
    };
  };
in {
  flake.aspects.jujutsu = {
    nixos = common;
    darwin = common;
  };
}
