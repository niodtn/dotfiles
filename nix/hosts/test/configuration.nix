{
  self,
  inputs,
  ...
}: {
  flake.darwinModules.macConfiguration = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.darwinModules.default
      self.darwinModules.hammerspoon

      self.commonModules.zsh
      self.commonModules.tailscale

      self.commonModules.ghostty
      self.commonModules.atuin
      self.commonModules.comma
    ];

    nixpkgs.hostPlatform = "aarch64-darwin";
  };
}
