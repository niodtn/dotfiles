{inputs, ...}: {
  imports = [
    inputs.flake-aspects.flakeModule
    (
      inputs.import-tree
      (i: i ./core)
    )
  ];

  flake-file.nixConfig = {
    abort-on-warn = false;
  };
}
