{...}: {
  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#desktop";
    };
  };
}
