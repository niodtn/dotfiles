{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.comma;
in {
  options.features.comma = {
    enable = mkEnableOption "comma feature";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.username} = {
      imports = [inputs.nix-index-database.homeModules.default];
      programs.nix-index.enable = true;
      programs.nix-index-database.comma.enable = true;
    };
  };
}
