{
  lib,
  config,
  inputs,
  pkgs,
  options,
  ...
}:
with lib; let
  cfg = config.features.spicetify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  options.features.spicetify = {
    enable = mkEnableOption "spicetify feature";
  };

  config = mkIf cfg.enable (mkMerge [
    # common
    {
      home-manager.users.${config.username} = {
        imports = [inputs.spicetify-nix.homeManagerModules.spicetify];

        programs.spicetify = {
          enable = true;
        };
      };
    }
    # linux
    (optionalAttrs (options ? boot) {
      home-manager.users.${config.username}.programs.spicetify = {};
    })
    # darwin
    (optionalAttrs (options ? homebrew) {
      home-manager.users.${config.username}.programs.spicetify = {
        theme = spicePkgs.themes.text;
      };
    })
  ]);
}
