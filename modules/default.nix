{inputs, ...}: {
  imports = [
    inputs.flake-aspects.flakeModule
    (
      inputs.import-tree
      (i: i [./core ./programs ./services])
    )
  ];

  flake-file.nixConfig = {
    abort-on-warn = false;
  };
}
