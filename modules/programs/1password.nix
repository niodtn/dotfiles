{lib, ...}: let
  common = {
    programs = {
      _1password.enable = true;
      _1password-gui.enable = true;
    };

    # services.onepassword-secrets = {
    #   enable = true;
    #   tokenFile = "/etc/opnix-token";
    # };
  };
in {
  flake.aspects.onePassword = {
    nixos = lib.mkMerge [
      common
      ({config, ...}: {
        programs._1password-gui.polkitPolicyOwners = [config.host.userName];
      })
    ];
    darwin = lib.mkMerge [
      common
      {
        environment.variables = {
          ONEPASSWORD_AGENT_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
        };
      }
    ];
  };
}
