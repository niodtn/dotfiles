{
  flake.aspects.core.nixos = {config, ...}: {
    users = {
      mutableUsers = false;
      users.${config.host.userName}.uid = 1001;
    };
  };
}
