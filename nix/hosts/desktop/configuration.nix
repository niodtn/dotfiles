{ flake, pkgs, ... }:

let
  username = "nixos";
in
{
  imports = [
    flake.nixosModules.default
    ./hardware.nix
    ./nvidia.nix
  ];

  environment.systemPackages = [
    (pkgs.bottles.override { removeWarningPopup = true; })
    pkgs.vulkan-loader
    # pkgs.gtkgreet
  ];

  # services.desktopManager.plasma6.enable = true;
  # services.greetd = {
  #   enable = true;
  #   package = pkgs.gtkgreet;
  #   settings.default_session.user = "greeter";
  # };

  services.getty.autologinUser = username;

  networking.hostName = "nixos-desktop";
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
