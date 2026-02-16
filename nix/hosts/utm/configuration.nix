{
  flake,
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    flake.nixosModules.default
    ./hardware.nix
  ];

  features = {
    zsh.enable = true;
    openssh.enable = true;

    # shell
    atuin.enable = true;
    comma.enable = true;
    direnv.enable = true;
    git.enable = true;
    jujutsu.enable = true;
    # python.enable = true;
    # starship.enable = true;

    # nixos
    systemd-boot.enable = true;
    plymouth.enable = true;
    sound.enable = true;
    tty-autologin.enable = true;
    gui = {
      enable = true;
      niri.enable = true;
    };

    # gui apps
    ghostty.enable = true;
    vesktop.enable = true;
    zen-browser.enable = true;
    vscode = {
      enable = true;
      nix.enable = true;
      minimal.enable = true;
    };
  };

  # for utm
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;
  environment.systemPackages = [pkgs.virglrenderer];
  hardware.graphics.extraPackages = [pkgs.mesa];

  networking.hostName = "utm";
  username = "niodtn";
  users.users.${config.username}.extraGroups = [
    "networkmanager"
    "wheel"
  ];
}
