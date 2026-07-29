{
  flake.aspects.cryptomator = {
    nixos = {
      config,
      pkgs,
      ...
    }: {
      programs.fuse.userAllowOther = true;

      home-manager.users.${config.host.userName} = {
        home.packages = [pkgs.cryptomator];
      };
    };
    darwin = {
      config,
      pkgs,
      ...
    }: {
      home-manager.users.${config.host.userName} = {
        home.packages = [pkgs.cryptomator-darwin];
      };
    };
  };
}
