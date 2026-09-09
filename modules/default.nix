{inputs, ...}: {
  imports = [
    inputs.flake-aspects.flakeModule
    inputs.flake-parts.flakeModules.modules

    (
      inputs.import-tree
      (i:
        i [
          ./core
          ./darwin
          ./nixos
          ./programs
          ./services
        ])
    )
  ];

  flake-file.nixConfig = {
    abort-on-warn = false;
  };
}
