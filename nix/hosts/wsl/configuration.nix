{
  flake,
  config,
  ...
}: {
  imports = [flake.nixosModules.wsl];

  features.tailscale.enable = true;

  wsl.defaultUser = config.username; # nixos-wsl
}
