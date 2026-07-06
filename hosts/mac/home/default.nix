{
  config,
  ...
}: {
  home-manager.users.${config.host.userName} = {
    home.stateVersion = "26.11";
  };
}
