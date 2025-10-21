{ flake, ... }:

let
  username = "nixos";
in
{
  imports = [ flake.nixosModules.wsl ];

  services.tailscale.enable = true;

  wsl.defaultUser = username; # nixos-wsl
  users.users.${username}.home = "/home/${username}";
}
