{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.htop
    pkgs.tailscale
  ];
}
