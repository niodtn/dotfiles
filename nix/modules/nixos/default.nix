{
  lib,
  pkgs,
  config,
  ...
}:
with lib; {
  imports = [
    ../common
    ./interop.nix
    ./kde.nix
  ];

  config = {
    # Bootloader.
    boot = {
      loader.systemd-boot.enable = true;
      loader.systemd-boot.consoleMode = "max";
      loader.efi.canTouchEfiVariables = true;
      kernelParams = [
        "quiet"
        "splash"
      ];
      plymouth.enable = true;
      plymouth.theme = "spinner";
    };

    time.hardwareClockInLocalTime = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ko_KR.UTF-8";
      LC_IDENTIFICATION = "ko_KR.UTF-8";
      LC_MEASUREMENT = "ko_KR.UTF-8";
      LC_MONETARY = "ko_KR.UTF-8";
      LC_NAME = "ko_KR.UTF-8";
      LC_NUMERIC = "ko_KR.UTF-8";
      LC_PAPER = "ko_KR.UTF-8";
      LC_TELEPHONE = "ko_KR.UTF-8";
      LC_TIME = "ko_KR.UTF-8";
    };

    fonts.packages = with pkgs; [
      noto-fonts-cjk-sans
    ];

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    services.xserver.enable = false;
    programs.xwayland.enable = true;
    programs.nix-ld.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    users.users.${config.username} = {
      isNormalUser = mkDefault true;
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };
}
