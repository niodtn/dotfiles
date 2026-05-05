{
  flake,
  config,
  ...
}: {
  imports = [flake.nixosModules.wsl];

  features.tailscale.enable = true;
}
