{
  flake,
  config,
  ...
}: {
  imports = [flake.nixosModules.wsl];

  features.tailscale.enable = true;

  username = "nixos";
  wsl.defaultUser = config.username; # nixos-wsl
  users.users.${config.username}.home = "/home/${config.username}";
}
