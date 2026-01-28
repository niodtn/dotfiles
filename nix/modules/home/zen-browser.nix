{
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.zen-browser;
in {
  imports = [inputs.zen-browser.homeModules.twilight];

  config = {
    programs.zen-browser = {
      enable = true;
    };
  };
}
