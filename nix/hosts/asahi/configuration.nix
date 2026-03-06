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

    ghostty.enable = true;
    zen-browser.enable = true;
    vscode.enable = true;
    spicetify.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  hardware.asahi.peripheralFirmwareDirectory = /boot/asahi;

  # wifi
  # networking.wireless.iwd = {
  #   enable = true;
  #   settings.General.EnableNetworkConfiguration = true;
  # };

  # plasma6
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  username = "niodtn";
  users.users.${config.username}.extraGroups = [
    "networkmanager"
    "wheel"
  ];
}
