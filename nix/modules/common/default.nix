{ lib, pkgs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  nix.gc.automatic = lib.mkDefault true;
  nix.gc.options = "--delete-older-than 30d";
  nix.optimise.automatic = lib.mkDefault true;
  nix.settings.auto-optimise-store = true;

  environment.systemPackages = [
    pkgs.nixfmt-rfc-style # For vscode Nix IDE extension
    pkgs.uv # Python version manager
  ];
}
