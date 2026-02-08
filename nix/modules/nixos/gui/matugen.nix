{
  perSystem,
  inputs,
  ...
}: {
  imports = [
    inputs.matugen.nixosModules.default
  ];
  environment.systemPackages = with pkgs; [
    perSystem.matugen.default
  ];
}
