{
  flake.aspects.cryptomator = {
    nixos = {};
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
