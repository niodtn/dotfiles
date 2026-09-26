{
  inputs,
  self,
  lib,
  ...
}: let
  system = "x86_64-linux";
in {
  flake.nixosConfigurations.${baseNameOf ./.} = inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    modules = with self.modules.nixos; [
      core
      services

      {
        host = {inherit system;};
      }
    ];
  };

  # config = lib.mkMerge [
  #   # VSCode Remote
  #   ({pkgs, ...}: {
  #     environment.systemPackages = [pkgs.wget];
  #     programs.nix-ld.enable = true;
  #     vscode-remote-workaround.enable = true;
  #   })
  # ];
}
