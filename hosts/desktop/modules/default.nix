{inputs, ...}: {
  imports = [
    (inputs.import-tree [./etc ./hardware ./wayland])
  ];
}
