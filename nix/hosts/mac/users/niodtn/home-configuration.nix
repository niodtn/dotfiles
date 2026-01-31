{pkgs, ...}: {
  home = {
    shellAliases = {
      rebuild = "sudo darwin-rebuild switch --flake ~/dotfiles#mac";
      ls = "lsd";
      ll = "lsd -al";
      cat = "bat";
    };

    packages = with pkgs; [
      lsd # `ls` command
      bat # `cat` command
    ];
  };

  # targets.darwin.copyApps.enableChecks = false;
}
