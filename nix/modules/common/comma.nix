{
  self,
  inputs,
  ...
}: {
  flake.commonModules.comma = {
    pkgs,
    config,
    ...
  }: {
    config = {
      # Nix Options
      environment.systemPackages = [pkgs.comma];

      # Home-Manager Options
      home-manager.users.${config.username} = {
        imports = [inputs.nix-index-database.homeModules.default];
        programs.nix-index.enable = true;
        programs.nix-index-database.comma.enable = true;
      };
    };
  };
}
