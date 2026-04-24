{
  self,
  inputs,
  ...
}: {
  flake.commonModules = {
    atuin = {config, ...}: {
      imports = [self.commonModules.atuin-default];
    };

    atuin-default = {config, ...}: {
      config.home-manager.users.${config.username}.programs.atuin = {
        enable = true;
        settings = {
          style = "auto";
          invert = true;
        };
      };
    };

    atuin-sync = {config, ...}: {
      imports = [self.commonModules.atuin-default];
      config.home-manager.users.${config.username}.programs.atuin = {
        daemon.enable = true;
        settings = {auto_sync = true;};
      };
    };
  };
}
