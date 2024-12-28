{ config, pkgs, ... }:

{
  environment.systemPackages =
    [
      # CLI tools
      pkgs.bat
      pkgs.neofetch

      pkgs.iterm2
    ];
}
