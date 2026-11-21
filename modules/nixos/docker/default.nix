{
  config,
  lib,
  ...
}: let
  cfg = config.nixos.docker;
in {
  options = {
    nixos.docker = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.docker.nixos = {
      config,
      pkgs,
      ...
    }: {
      users.users.${config.host.userName}.extraGroups = ["podman"];

      virtualisation = {
        oci-containers.backend = "podman";
        podman = {
          enable = true;
          dockerCompat = true;

          defaultNetwork.settings.dns_enabled = true;
        };
      };

      environment.systemPackages = with pkgs; [
        # podman-compose
        # podman-tui
      ];
    };    
  };
}
