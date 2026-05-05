{self, ...}: {
  imports = [
    (self.paths.modules "common/username.nix")
  ];
  # Nix
  nix.settings = {
    experimental-features = "nix-command flakes";
    # caches
    extra-substituters = self.caches.substituters;
    extra-trusted-public-keys = self.caches.trustedPublicKeys;
  };
  nixpkgs.config.allowUnfree = true;

  ## Shell Alliases
  environment.shellAliases = {
    ll = "ls -l";
    ".." = "cd ../";
    "..." = "cd ../../";
  };

  # Home Manager
  home-manager.backupFileExtension = "backup";
}
