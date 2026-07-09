let
  version = "1.19.3";
  hash = "sha256-C/6MauuXrPY4gQ4+V2AW21ELx79xNm3ADzx+6poxTyM=";

  overlay = self: super: {
    cryptomator-darwin = super.stdenvNoCC.mkDerivation {
      pname = "cryptomator-darwin";
      inherit version;

      src = super.fetchurl {
        url = "https://github.com/cryptomator/cryptomator/releases/download/${version}/Cryptomator-${version}-arm64.dmg";
        inherit hash;
      };

      nativeBuildInputs = [super.undmg];

      sourceRoot = ".";

      installPhase = ''
        runHook preInstall

        mkdir -p "$out/Applications"
        cp -R "Cryptomator.app" "$out/Applications/"

        runHook postInstall
      '';
    };
  };
in {
  flake.aspects.core.darwin = {
    nixpkgs.overlays = [overlay];
  };
}
