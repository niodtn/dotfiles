{ inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  programs.hyprland.enable = true;
  wayland.windowManager.hyprland.enable = true;
}
