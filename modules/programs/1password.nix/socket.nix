{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.programs._1password {
    flake.aspects.programs = {
      nixos = {
        environment.etc."ssh/ssh_config.d/1password.conf".text = ''
          Host *
            IdentityAgent ~/.1password/agent.sock
        '';
      };

      darwin = {
        environment.variables = {
          ONEPASSWORD_AGENT_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
        };
      };
    };
  };
}
