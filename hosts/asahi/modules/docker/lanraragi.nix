{
  lib,
  ...
}: {
  inputs.docker = true;
    
  flake.aspects.asahi.nixos = lib.mkMerge [
    ({...}: let
      lanraragiDir = "/home/niodtn/lanraragi";
    in {
      virtualisation.oci-containers.containers = {
        "lanraragi" = {
          image = "docker.io/difegue/lanraragi";
          ports = ["3000:3000"];
          autoStart = true;

          environment = {
            LRR_UID = "1000";
            LRR_GID = "1000";
          };

          volumes = [
            "${lanraragiDir}/content:/home/koyomi/lanraragi/content:z"
            "${lanraragiDir}/database:/home/koyomi/lanraragi/database:z"
            "${lanraragiDir}/thumb:/home/koyomi/lanraragi/thumb:z"
          ];
        };
      };

      systemd.tmpfiles.rules = [
        "d ${lanraragiDir} 0755 1000 1000 -"
        "d ${lanraragiDir}/content 0755 1000 1000 -"
        "d ${lanraragiDir}/database 0755 1000 1000 -"
        "d ${lanraragiDir}/thumb 0755 1000 1000 -"
      ];
    })

    ({
      pkgs,
      ...
    }: let
      lrrReactSrc = pkgs.fetchFromGitHub {
        owner = "hibikikuze4dan";
        repo = "lanraragi-react-web-v2";
        rev = "master";
        sha256 = "sha256-7BCqoROm9FSZcgd9BCr4xT0utW5QewlvMGMcu1oaJTE=";
      };
    in {
      system.activationScripts.build-lrr-react = {
        text = ''
          rm -rf /tmp/lrr-react-build
          cp -r ${lrrReactSrc} /tmp/lrr-react-build
          chmod -R +w /tmp/lrr-react-build

          SED="${pkgs.gnused}/bin/sed"
          $SED -i 's|FROM node:20-alpine|FROM docker.io/library/node:20-alpine|g' /tmp/lrr-react-build/Dockerfile
          $SED -i 's|FROM nginx:alpine|FROM docker.io/library/nginx:alpine|g' /tmp/lrr-react-build/Dockerfile
          
          ${pkgs.podman}/bin/podman build -t localhost/lrr-react-local:latest /tmp/lrr-react-build
        '';
      };

      virtualisation.oci-containers.containers."lrr-react" = {
        image = "localhost/lrr-react-local:latest";
        ports = ["3001:22498"];
        autoStart = true;
      };
    })
  ];
}
