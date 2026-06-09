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
    dotnet-sdk_10
    go
    graphviz
    opencode
    pyenv
    yarn
  ];

  # FNM (Fast Node Manager) replaces NVM — managed via Nix.
  # It's initialized in shell.nix initExtra.
}
