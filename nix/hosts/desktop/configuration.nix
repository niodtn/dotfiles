{
  flake,
  pkgs,
  config,
  ...
}: {
  imports = [
    flake.nixosModules.default
    ./hardware.nix
    ./nvidia.nix
  ];

  features = {
    zsh.enable = true;
    tailscale.enable = true;

    # shell
    atuin.enable = true;
    direnv.enable = true;
    git.enable = true;
    jujutsu.enable = true;
    python.enable = true;
    starship.enable = true;

    # nixos
    systemd-boot.enable = true;
    plymouth.enable = true;
    sound.enable = true;
    tty-autologin.enable = true;
    bluetooth.enable = true;
    gui = {
      enable = true;
      niri.enable = true;
    };

    # gui
    ghostty.enable = true;
    vesktop.enable = true;
    zen-browser.enable = true;
    vscode = {
      enable = true;
      nix.enable = true;
      minimal.enable = true;
    };
  };

  environment.systemPackages = [
    pkgs.google-chrome
    pkgs.github-cli
  ];

  username = "niodtn";
  users.users.${config.username}.extraGroups = [
    "networkmanager"
    "wheel"
  ];
}
