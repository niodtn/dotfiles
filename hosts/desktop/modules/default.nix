{inputs, ...}: {
  imports = [
    (inputs.import-tree [./etc ./wm])
  ];

  flake-file.nixConfig = {
    extra-substituters = [];
    extra-trusted-public-keys = [];
  };

  flake.aspects.host-desktop.nixos = {
    imports = [./_hardware];
  };
}
