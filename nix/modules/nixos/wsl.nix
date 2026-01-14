{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../common
    ./interop.nix
  ];

  config = {
    wsl.enable = true;
    programs.nix-ld.enable = true;
    wsl.wslConf.boot.systemd = true;

    environment.systemPackages = [
      pkgs.wslu
    ];
  };
}
