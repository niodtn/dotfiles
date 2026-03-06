{...}: {
  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#asahi --impure";
      ll = "ls -al";
    };
  };
}
