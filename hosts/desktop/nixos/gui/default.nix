{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./gnome
  ];

  config = lib.mkMerge [
    # Sound
    {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      security.rtkit.enable = true;
    }

    # XDG Portal
    {
      services.dbus.enable = true;
      environment.systemPackages = [pkgs.xdg-utils];

      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = lib.mkDefault ["gtk"];
      };
    }

    # Wayland
    {
      environment.variables = {NIXOS_OZONE_WL = "1";};
      programs.xwayland.enable = true;
      users.users.${config.host.userName}.extraGroups = ["video"];
    }

    # etc
    {
      security.polkit.enable = true;
    }
  ];
}
