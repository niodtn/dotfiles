let
  version = "2.2.0";

  overlay = self: super: {
    amethyst-mod-manager = super.python3Packages.buildPythonApplication {
      pname = "amethyst-mod-manager";
      inherit version;

      format = "other";

      src = super.fetchFromGitHub {
        owner = "ChrisDKN";
        repo = "Amethyst-Mod-Manager";
        rev = "v${version}";
        hash = "sha256-1ZahPn/eBTXWV3GR17PzhzVnp+xx2QDJQkThjzmcpDY=";
      };

      postPatch = ''
        chmod +x src/version.py
        patchShebangs src/version.py
      '';

      nativeBuildInputs = with super; [
        meson
        ninja
        pkg-config
        wrapGAppsHook4
        makeWrapper
      ];

      propagatedBuildInputs = with super.python3Packages; [
        pyside6
        pygobject3
        pillow
        certifi
        requests
        keyring
        secretstorage
        cryptography
        jeepney
        msgpack
        lz4
        py7zr
        zstandard
        rarfile
        bsdiff4
      ];

      postInstall = ''
        pythonPath="$out/${super.python3.sitePackages}:$PYTHONPATH"

        substituteInPlace $out/bin/amethyst-mod-manager \
          --replace-fail "python3" "${super.python3}/bin/python3"

        if [ -f $out/bin/amethyst-mod-manager-cli ]; then
          substituteInPlace $out/bin/amethyst-mod-manager-cli \
            --replace-fail "python3" "${super.python3}/bin/python3"
        fi

        wrapProgram $out/bin/amethyst-mod-manager \
          --prefix PYTHONPATH : "$pythonPath" \
          --prefix PATH : ${super.lib.makeBinPath [super.python3]}

        if [ -f $out/bin/amethyst-mod-manager-cli ]; then
          wrapProgram $out/bin/amethyst-mod-manager-cli \
            --prefix PYTHONPATH : "$pythonPath" \
            --prefix PATH : ${super.lib.makeBinPath [super.python3]}
        fi
      '';

      meta = with super.lib; {
        description = "A Linux native mod manager for a variety of games";
        homepage = "https://github.com/ChrisDKN/Amethyst-Mod-Manager";
        license = licenses.gpl3Only;
        mainProgram = "amethyst-mod-manager";
        platforms = platforms.linux;
      };
    };
  };
in {
  flake.aspects.core.nixos = {
    nixpkgs.overlays = [overlay];
  };
}
