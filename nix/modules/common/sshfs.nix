{
  lib,
  config,
  options,
  ...
}:
with lib; let
  cfg = config.features.sshfs;
  hasHomebrew = hasAttrByPath ["homebrew"] options;
in {
  options.features.sshfs = {
    enable = mkEnableOption "sshfs feature";
  };

  config = mkIf cfg.enable (mkMerge [
    # common
    {
      features.openssh.enable = mkForce true;
    }
    # nixos
    (optionalAttrs (!hasHomebrew) {
      environment.systemPackages = [pkgs.sshfs];
    })
    # darwin
    (optionalAttrs hasHomebrew {
      homebrew.casks = [
        "fuse-t"
        "fuse-t-sshfs"
      ];
    })
  ]);
}
