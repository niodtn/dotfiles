{ config, pkgs, ... }:

{
  environment.systemPackages =
    [
      # CLI tools
      pkgs.devenv
      pkgs.nixpkgs-fmt
      pkgs.bat
      pkgs.neofetch

      pkgs.tailscale
      pkgs.iterm2
    ];
}
