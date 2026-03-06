{
  inputs,
  flake,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.apple-silicon-support.nixosModules.apple-silicon-support
    flake.nixosModules.default
  ];

  features = {
    zsh.enable = true;

    # shell
    comma.enable = true;
    direnv.enable = true;
    git.enable = true;
    jujutsu.enable = true;
    starship.enable = true;

    # nixos
    tty-autologin.enable = true;
    gui = {
      enable = true;
      kde.enable = true;
    };

    # gui
    ghostty.enable = true;
    zen-browser.enable = true;
    vscode = {
      enable = true;
      nix.enable = true;
    };
    # spicetify.enable = true;
  };

  # asahi
  hardware.asahi.peripheralFirmwareDirectory = /boot/asahi;
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };

  # wifi
  # networking.wireless.iwd = {
  #   enable = true;
  #   settings.General.EnableNetworkConfiguration = true;
  # };

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  username = "niodtn";
  users.users.${config.username}.extraGroups = [
    "networkmanager"
    "wheel"
  ];
}
