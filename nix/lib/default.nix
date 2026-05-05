{self, ...}: {
  flake = {
    caches = import ./caches.nix;
    paths = import ./paths.nix {inherit self;};
  };
}
