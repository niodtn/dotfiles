{inputs, ...}: {
  imports = [
    inputs.flake-aspects.flakeModule
    (
      inputs.import-tree
      (i: i ./configs)
    )
  ];

  flake-file.nixConfig = {
    abort-on-warn = false;
  };
}
