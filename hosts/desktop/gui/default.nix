{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./gnome.nix
  ];

  services = {
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = lib.mkDefault ["gtk"];
  };

  environment = {
    systemPackages = [pkgs.xdg-utils];
    variables = {NIXOS_OZONE_WL = "1";};
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  fonts.packages = [pkgs.noto-fonts-cjk-sans];
  programs.xwayland.enable = true;
  users.users.${config.host.userName}.extraGroups = ["video"];
}
