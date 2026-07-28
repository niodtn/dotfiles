{lib, ...}: let
  common = {
    programs = {
      _1password.enable = true;
      _1password-gui.enable = true;
    };
  };
in {
  flake.aspects.onePassword = {
    nixos = lib.mkMerge [
      common

      # Socket
      {
        environment.etc."ssh/ssh_config.d/1password.conf".text = ''
          Host *
            IdentityAgent ~/.1password/agent.sock
        '';
      }

      # etc
      ({config, ...}: {
        programs._1password-gui.polkitPolicyOwners = [config.host.userName];
      })

      # Zen Browser
      {
        environment.etc = {
          "1password/custom_allowed_browsers" = {
            text = ".zen-wrapped\nzen";
            mode = "0755";
          };
        };
      }
    ];
    darwin = lib.mkMerge [
      common

      # Socket
      {
        environment.variables = {
          ONEPASSWORD_AGENT_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
        };
      }
    ];
  };
}
