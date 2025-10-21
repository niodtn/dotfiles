{ flake, config, ... }:

let
  username = "nixos";
in
{
  imports = [
    flake.nixosModules.default
    ./hardware.nix
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = username;

  networking.hostName = username; # NixOS
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
