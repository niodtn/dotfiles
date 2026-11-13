inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  imports = [
    ../default.nix
    ./modules
    ./configuration.nix
  ];

  inputs.apple-silicon-support = true;
  flake.aspects.core.nixos = {config, ...}: {
    host.hostName = baseNameOf ./.;

    # statVersions
    system.stateVersion = "26.11";

    # Passwords
    users.users = {
      root.hashedPassword = "!";
      ${config.host.userName}.hashedPassword = "$6$BkMjpupvNHMN4f8H$RQAtarFgnCg2kjJYnO29z4feEzpao1dnCFBKr9AGBReK5Etx.8Z7EvBCVOtxASQcMyzpiyxQM2cfR2zVK5lSv/";
    };
  };
}

