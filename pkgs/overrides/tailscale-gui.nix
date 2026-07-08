let
  version = "1.98.8";
  hash = "sha256-FACQrLyZEZZ7/ylFcmVvOzZ8OVvoXoQn7iJJ1BInmGQ=";

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
