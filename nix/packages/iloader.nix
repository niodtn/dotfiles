{
  pkgs,
  perSystem,
  ...
}: let
  version = "1.1.6";
  sha256 = "sha256-OQa5cQx2KIh1op3wMH0I8v9vXOq6PeF00Z0NQRL823s=";
in
  pkgs.stdenvNoCC.mkDerivation {
    name = "iloader";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/nab138/iloader/releases/download/v${version}/iloader-darwin-universal.app.tar.gz";
      inherit sha256;
    };

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/Applications"
      cp -r iloader.app "$out/Applications/"

      runHook postInstall
    '';
  }
