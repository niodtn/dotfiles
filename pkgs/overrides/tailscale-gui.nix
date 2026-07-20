let
  version = "1.98.9";
  hash = "sha256-n+behR4E/RbUdLmlZmIuDMxkD9Cjw7BHUWFn9ELaew4=";

  overlay = self: super: {
    tailscale-gui =
      if super.lib.versionOlder super.tailscale-gui.version version
      then
        super.tailscale-gui.overrideAttrs (oldAttrs: {
          inherit version;
          src = super.fetchurl {
            url = "https://pkgs.tailscale.com/stable/Tailscale-${version}-macos.pkg";
            inherit hash;
          };
        })
      else super.tailscale-gui;
  };
in {
  flake.aspects.core.darwin = {
    nixpkgs.overlays = [overlay];
  };
}
