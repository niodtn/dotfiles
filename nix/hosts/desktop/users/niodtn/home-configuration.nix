{...}: {
  home = {
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#desktop";
      rebuild-boot = "sudo nixos-rebuild boot --flake ~/dotfiles#desktop";
      ll = "ls -al";
    };
  };
}
