{
  config,
  lib,
  ...
}: let
  cfg = config.services.couchdb;
  tailscaleEnabled = config.services.tailscale;
in {
  options = {
    services.couchdb = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg {
    flake.aspects.core.nixos = lib.mkMerge [
      ({pkgs, ...}: {
        services.couchdb = {
          enable = true;
          package = pkgs.couchdb3;
          port = 5984;

          extraConfig = {
            couchdb.single_node = true;
            couchdb.max_document_size = 50000000;

            httpd.WWW-Authenticate = ''Basic realm="couchdb"'';
            httpd.enable_cors = true;

            chttpd.require_valid_user = true;
            chttpd.enable_cors = true;
            chttpd.max_http_request_size = "4294967296";

            cors.origins = "app://obsidian.md,capacitor://localhost,http://localhost";
            cors.credentials = true;
            # cors.headers = "accept, authorization, content-type, origin, referer";
            # cors.methods = "GET, PUT, POST, HEAD, DELETE";
          };
        };
      })

      (lib.mkIf tailscaleEnabled {
        services.tailscale.serve = {
          # enable = true;
          # services.couchdb.endpoints = {
          #   "tcp:443" = "http://127.0.0.1:5984";
          # };
        };
        
        services.couchdb = {
          bindAddress = "127.0.0.1";
          adminUser = "admin";
          adminPass = "admin";
        };
      })
    ];
  };
}
