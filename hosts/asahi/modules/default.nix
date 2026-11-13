{
  inputs,
  lib,
  ...
}: {
  imports = [
    (inputs.import-tree [./hardware])
  ];

  flake.aspects.asahi.nixos = lib.mkMerge [  
    # TTY
    ({config, ...}:{
      services = {
        kmscon = {
          # enable = true;
          config.hwaccel = true;
          # extraConfig = "font-size=14";
        };

        getty.autologinUser = config.host.userName;
      };
    })
  ];
}
