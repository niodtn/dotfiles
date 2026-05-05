{lib, ...}: {
  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#asahi --impure";
    };
  };

  #vscode
  programs.vscode.profiles.default = {
    userSettings = {
      "window.titleBarStyle" = lib.mkForce "custom";
    };
  };
}
