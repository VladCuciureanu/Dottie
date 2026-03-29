{ pkgs, ... }: {
  home.packages = with pkgs; [
    claude-code
    curl
    eza
    fd
    ripgrep
    bat
    pyenv
  ];

  # NVM is managed via its install script, not Nix.
  # It's sourced in shell.nix initExtra.
}
