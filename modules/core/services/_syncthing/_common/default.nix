{config, ...}: {
  imports = [./devices.nix];

  home-manager.users.${config.host.userName} = {
    imports = [./home.nix];
  };
}
