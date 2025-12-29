{ pkgs, ... }:

with pkgs.vscode-extensions;
[
  esbenp.prettier-vscode

  # Themes
  sdras.night-owl # White Theme
  zhuangtongfa.material-theme # Dark Theme
  pkief.material-icon-theme # Icon

  # Remote Development
  # ms-vscode-remote.remote-containers
  ms-vscode-remote.remote-wsl
  ms-vscode-remote.remote-ssh

  # Copilot
  # github.copilot
  # github.copilot-chat

  # Nix
  jnoortheen.nix-ide

  # Jupyter
  ms-toolsai.jupyter-keymap
  ms-toolsai.jupyter-renderers
  ms-toolsai.vscode-jupyter-cell-tags
  ms-toolsai.vscode-jupyter-slideshow
]
