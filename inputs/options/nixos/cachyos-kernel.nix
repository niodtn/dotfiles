{
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    inputs.cachyos-kernel = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.inputs.cachyos-kernel {
    flake-file = {
      inputs.cachyos-kernel = {
        url = "github:xddxdd/nix-cachyos-kernel/release";
      };

      nixConfig = {
        extra-substituters = [
          "https://attic.xuyh0120.win/lantian"
          "https://cache.garnix.io"
        ];
        extra-trusted-public-keys = [
          "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        ];
      };
    };

    flake.aspects.core.nixos = {
      nixpkgs.overlays = [inputs.cachyos-kernel.overlays.pinned];
    };
  };
}
