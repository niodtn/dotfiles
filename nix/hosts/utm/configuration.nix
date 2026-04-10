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
      labwc.enable = true;
    };

    # gui apps
    # vesktop.enable = true;
    # zen-browser.enable = true;
    # vscode = {
    #   enable = true;
    #   nix.enable = true;
    #   minimal.enable = true;
    # };
  };

  # for utm
  environment = {
    variables = {
      GS_GL_RENDERER = "gl";
    };
    systemPackages = [pkgs.virglrenderer];
  };

  services = {
    spice-vdagentd.enable = true;
    qemuGuest.enable = true;
  };

  hardware.graphics.extraPackages = [pkgs.mesa];
  powerManagement.cpuFreqGovernor = "performance";

  networking.hostName = "utm";
  username = "niodtn";
  users.users.${config.username}.extraGroups = [
    "networkmanager"
    "wheel"
  ];
}
