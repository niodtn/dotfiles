{inputs, ...}: {
  imports = [
    (inputs.import-tree [./custom ./overrides])
  ];
}
