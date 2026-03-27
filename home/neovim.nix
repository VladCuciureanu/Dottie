{ ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Symlink the NvChad config directory
  xdg.configFile."nvim".source = ../config/nvim;
}
