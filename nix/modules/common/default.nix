{ pkgs, ... }:

{
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.nixfmt-rfc-style # For vscode Nix IDE extension
    pkgs.uv # Python version manager
  ];
}
