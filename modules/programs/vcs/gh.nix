let
  common = {config,...}:{
    home-manager.users.${config.host.userName} = {
      programs.gh = {
        enable = true;
      };
    };
  };
in {
  flake.aspects.gh = {
    nixos = common;
    darwin = common;
  };
}