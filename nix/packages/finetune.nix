{
  pkgs,
  perSystem,
  ...
}: let
  # https://github.com/ronitsingh10/FineTune/releases
  version = "1.6.0";
  sha256 = "sha256-vT5A3mBaCOlNpTfx//ch4KqGWZixhMGO+BoWUt0foNY=";
in
  pkgs.stdenvNoCC.mkDerivation {
    pname = "finetune";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/ronitsingh10/FineTune/releases/download/v${version}/FineTune.dmg";
      inherit sha256;
    };

    nativeBuildInputs = [pkgs._7zz];

    sourceRoot = ".";

    unpackPhase = ''
      7zz x $src
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/Applications"
      cp -r FineTune.app "$out/Applications/"

      runHook postInstall
    '';
  }
