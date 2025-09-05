{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.wget
    pkgs.git
    pkgs.nixfmt-rfc-style # For vscode Nix IDE extension
    pkgs.uv # Python version manager
  ];
}
