{
  inputs,
  flake,
  lib,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    flake.nixosModules.default
  ];

  features = {
    zsh.enable = true;
    tailscale.enable = true;

    # shell
    comma.enable = true;
    direnv.enable = true;
    git.enable = true;
    jujutsu.enable = true;
    starship.enable = true;

    # nixos
    tty-autologin.enable = true;
    bluetooth.enable = true;
    gui = {
      enable = true;
      # kde.enable = true;
      labwc.enable = true;
    };

    # gui
    ghostty.enable = true;
    zen-browser.enable = true;
    vscode = {
      enable = true;
      minimal.enable = true;
      nix.enable = true;
    };
    # spicetify.enable = true;
  };

  # asahi
  boot.loader.grub.enable = lib.mkForce false;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };

  # wifi
  # networking.wireless.iwd = {
  #   enable = true;
  #   settings.General.EnableNetworkConfiguration = true;
  # };

  users.users.${config.username}.extraGroups = [
    "networkmanager"
    "wheel"
  ];
}
