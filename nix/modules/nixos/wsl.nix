{ inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../common
  ];

  config = {
    wsl.enable = true;
    programs.nix-ld.enable = true;
    services.dbus.enable = true;
    wsl.wslConf.boot.systemd = true;
  };
}
