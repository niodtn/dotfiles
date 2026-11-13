{
  lib,
  config,
  ...
}: {
  options = {
    services.tailscale = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.services.tailscale {
    flake.aspects.services = {
      nixos = {
        services.tailscale.enable = true;
        networking.firewall.trustedInterfaces = ["tailscale0"];        
      };
      
      darwin = {pkgs, ...}: {environment.systemPackages = [pkgs.tailscale-gui];};
    };
  };
}
