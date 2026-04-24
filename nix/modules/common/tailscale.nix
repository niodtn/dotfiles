{
  self,
  inputs,
  ...
}: {
  flake.commonModules.tailscale = {
    lib,
    options,
    ...
  }: {
    config = lib.mkMerge [
      # linux
      (lib.optionalAttrs (options ? boot) {
        services.tailscale = {
          enable = true;
          extraUpFlags = ["--ssh"];
        };
      })
      # Darwin
      (lib.optionalAttrs (options ? homebrew) {
        homebrew.casks = ["tailscale-app"];
      })
    ];
  };
}
