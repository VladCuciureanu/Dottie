# TLDR

## Structure

```
flake.nix              <- entry point, defines two hosts
├── hosts/
│   ├── darwin/
│   │   ├── common/    <- shared macOS: Homebrew casks, fonts, Touch ID sudo, system prefs
│   │   └── razumikhin/<- this machine (host-specific overrides go here)
│   └── linux/
│       ├── common/    <- shared Linux (mostly empty)
│       └── frank/     <- a Linux host (minimal)
├── home/              <- Home Manager, shared across all platforms
│   ├── packages.nix   <- CLI tools: eza, fd, ripgrep, bat, pyenv
│   ├── shell.nix      <- zsh config: aliases, plugins, starship prompt, fzf, zoxide
│   ├── git.nix        <- git (minimal currently)
│   └── neovim.nix     <- NvChad, symlinked from config/nvim
└── config/nvim/       <- NvChad neovim config
```

## Key Concepts

- **`flake.nix`** has two builder functions: `mkDarwin` (nix-darwin + home-manager) and `mkLinux` (standalone home-manager). Adding a host = new folder + one entry in the flake outputs.
- **`hosts/`** = system-level, platform-specific config (Homebrew, macOS defaults, networking).
- **`home/`** = user-level, cross-platform config (shell, editor, packages). This is what both macOS and Linux hosts share.
- **Determinate Nix** manages the daemon, so `nix.enable = false` in darwin config.

## Day-to-Day Commands

| Task | Command |
|---|---|
| Rebuild after edits | `darwin-rebuild switch --flake .#Razumikhin` |
| Update all inputs | `nix flake update` then rebuild |
| Update one input | `nix flake update home-manager` then rebuild |
| Add a CLI tool | Add to `home/packages.nix` |
| Add a GUI app (macOS) | Add cask to `hosts/darwin/common/default.nix` |
| Add a zsh alias/plugin | Edit `home/shell.nix` |
| Change macOS defaults | Edit `hosts/darwin/common/preferences.nix` |
| Add a new macOS host | New folder in `hosts/darwin/`, add to flake outputs |

## Things to Know

- **Homebrew cleanup is aggressive** — `onActivation.cleanup = "zap"` removes anything not declared. If you `brew install` something manually, it'll be wiped on next rebuild. Declare it or lose it.
- **Shell config deprecation warnings** — `programs.zsh.initExtra`/`initExtraFirst` are deprecated in favor of `programs.zsh.initContent`. Worth migrating when you get a chance.
- **Git config is minimal** — `home/git.nix` just enables git. Your name, email, signing, aliases etc. could be declared there.
- **Linux host "Frank"** is a skeleton — ready to flesh out when needed.
- **NvChad** config lives in `config/nvim/` and is symlinked in, not managed by Nix.
