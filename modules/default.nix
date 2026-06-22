{inputs, ...}: {
  imports = [
    inputs.flake-aspects.flakeModule
    (
      inputs.import-tree
      (i: i ./configs)
    )
  ];
}
