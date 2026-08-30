{inputs, ...}: {
  imports = [
    (inputs.import-tree [./etc ./hardware ./wm])
  ];
}
