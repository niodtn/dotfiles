{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.spicetify;
in {
  options.features.spicetify = {
    enable = mkEnableOption "spicetify feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      imports = [inputs.spicetify-nix.homeManagerModules.spicetify];

      programs.spicetify = {
        enable = true;
      };
    };
  };
}
