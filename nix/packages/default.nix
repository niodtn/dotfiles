{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages =
      # common
      {}
      # linux
      // (lib.optionalAttrs pkgs.stdenv.isLinux {})
      # darwin
      // (lib.optionalAttrs pkgs.stdenv.isDarwin {
        finetune = pkgs.callPackage ./finetune.nix {};
        iloader = pkgs.callPackage ./iloader.nix {};
        vesktop-bin = pkgs.callPackage ./vesktop-bin.nix {};
      });
  };

  flake.overlays.default = final: prev: (self.packages.${final.system} or {});
}
