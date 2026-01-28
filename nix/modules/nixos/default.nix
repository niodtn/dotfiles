{
  lib,
  pkgs,
  config,
  ...
}:
with lib; {
  imports = [
    ../common

    ./hyprland

    ./bluetooth.nix
    ./interop.nix
    ./kde.nix
    ./plymouth.nix
    ./sound.nix
    ./systemd-boot.nix
    ./tty-autologin.nix
  ];

  config = {
    # For Windows dual-boot
    time.hardwareClockInLocalTime = true;

    # Enable networking
    networking.networkmanager.enable = true;
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    fonts.packages = with pkgs; [
      noto-fonts-cjk-sans
    ];

    programs.nix-ld.enable = true;

    users.users.${config.username} = {
      isNormalUser = mkDefault true;
    };
  };
}
