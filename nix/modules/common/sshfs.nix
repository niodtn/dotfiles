{
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.features.sshfs;
in {
  options.features.sshfs = {
    enable = mkEnableOption "sshfs feature";
  };

  config = mkIf cfg.enable (mkMerge [
    # common
    {
      features.openssh.enable = mkForce true;
    }
    # linux
    (optionalAttrs (options ? boot) {
      environment.systemPackages = [pkgs.sshfs];
    })
    # darwin
    (optionalAttrs (options ? homebrew) {
      homebrew.casks = [
        "fuse-t"
        "fuse-t-sshfs"
      ];
    })
  ]);
}
