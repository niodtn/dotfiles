{
  inputs,
  ...
}: {
  imports = [
    (inputs.import-tree [./hardware])
  ];
}
