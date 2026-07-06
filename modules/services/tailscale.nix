{
  flake.aspects.tailscale = {
    nixos = {
      services.tailscale.enable = true;

      networking.firewall = {
        enable = true;
        trustedInterfaces = ["tailscale0"];
      };
    };
    darwin = {pkgs, ...}: {
      environment.systemPackages = [
        pkgs.tailscale-gui
      ];
    };
  };
}
