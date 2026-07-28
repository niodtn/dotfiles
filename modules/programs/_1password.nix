{lib, ...}: {
  flake.aspects.onePassword = {
    nixos = lib.mkMerge [
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
  };
}
