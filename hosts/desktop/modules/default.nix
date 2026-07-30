{inputs, ...}: {
  imports = [
    (inputs.import-tree [./etc ./wm])
  ];

  flake.aspects.host-desktop.nixos = {
    imports = [./_hardware];
  };
}
