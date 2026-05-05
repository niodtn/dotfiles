{
  stdenvNoCC,
  fetchurl,
  unzip,
  ...
}: let
  # https://github.com/Vencord/Vesktop/releases
  version = "1.6.5";
  sha256 = "sha256-VhWrPn7i1XEs5ZLPSouPcNCvWubQGOcop5HmgCpcUDQ=";
in
  stdenvNoCC.mkDerivation {
    pname = "vesktop-bin";
    inherit version;

    src = fetchurl {
      url = "https://github.com/Vencord/Vesktop/releases/download/v${version}/Vesktop-${version}-universal-mac.zip";
      inherit sha256;
    };

    nativeBuildInputs = [unzip];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/Applications"
      cp -r Vesktop.app "$out/Applications/"

      runHook postInstall
    '';
  }
