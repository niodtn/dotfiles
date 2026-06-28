# https://wiki.nixos.org/wiki/GNOME#dconf
{lib, ...}: let
  mkLocked = path: key: value: {
    # locks = ["${path}/${key}"]; # TODO: `locks` doesn't works
    lockAll = true;
    settings = {
      "${path}" = {
        "${key}" = value;
      };
    };
  };
  applyTo = targets: setting:
    lib.genAttrs targets (target: {databases = [setting];});
in {
  programs.dconf = {
    enable = true;
    profiles = lib.mkMerge [
      # Power -> Power Saving
      ## -> Automatic Screen Blank = false
      (applyTo ["user"] (mkLocked "org/gnome/desktop/session" "idle-delay" (lib.gvariant.mkUint32 0)))
      ## -> Automatic Suspend = false
      (applyTo ["gdm" "user"] (mkLocked "org/gnome/settings-daemon/plugins/power" "sleep-inactive-ac-type" "nothing"))

      # Multitasking -> Screen Edges
      ## -> Hot Corner = false
      (applyTo ["user"] (mkLocked "org/gnome/desktop/interface" "enable-hot-corners" false))

      # Mouse & Touchpad -> Mouse
      ## -> Mouse Acceleration = false
      (applyTo ["gdm" "user"] (mkLocked "org/gnome/desktop/peripherals/mouse" "accel-profile" "flat"))
    ];
  };
}
