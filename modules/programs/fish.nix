let
  common = {
    pkgs,
    config,
    ...
  }: {
    environment.shells = [pkgs.fish];
    programs.fish.enable = true;
    users.users.${config.host.userName}.shell = pkgs.fish;

    home-manager.users.${config.host.userName} = {
      programs.fish = {
        enable = true;

        interactiveShellInit = ''
          set -g fish_greeting ""
        '';
      };
    };
  };
in {
  flake.aspects.fish = {
    nixos = common;
    darwin = common;
  };
}
