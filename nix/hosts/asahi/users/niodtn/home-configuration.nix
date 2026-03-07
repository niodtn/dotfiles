{lib, ...}: {
  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#asahi --impure";
      ll = "ls -al";
    };
  };

  #vscode
  programs.vscode.profiles.default = {
    userSettings = {
      "window.titleBarStyle" = lib.mkForce "custom";
    };
  };
}
