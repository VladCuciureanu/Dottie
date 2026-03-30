{ pkgs, ... }: {
  home.packages = with pkgs; [
    claude-code
    curl
    eza
    fd
    gh
    ripgrep
    bat
    bun
    deno
    pnpm
    fnm
    pyenv
    yarn
  ];

  # FNM (Fast Node Manager) replaces NVM — managed via Nix.
  # It's initialized in shell.nix initExtra.
}
