# Dotfiles

Cross-platform (macOS + Linux) dotfiles managed with [Nix](https://nixos.org/), [nix-darwin](https://github.com/LnL7/nix-darwin), and [Home Manager](https://github.com/nix-community/home-manager).

## Prerequisites

Install Nix with flakes enabled:

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Setup

### macOS

```sh
git clone git@github.com:VladCuciureanu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
nix run nix-darwin -- switch --flake .#Razumikhin
```

After the first build:

```sh
darwin-rebuild switch --flake ~/.dotfiles#Razumikhin
```

### Linux

```sh
git clone git@github.com:VladCuciureanu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
nix run home-manager -- switch --flake .#Frank
```

After the first build:

```sh
home-manager switch --flake ~/.dotfiles#Frank
```

## Adding a new host

1. Create `hosts/darwin/<hostname>/default.nix` (macOS) or `hosts/linux/<hostname>/default.nix` (Linux)
2. Import `../common` in that file for shared platform config
3. Add one line to `flake.nix`:
   ```nix
   # macOS
   "MyMac" = mkDarwin { hostname = "MyMac"; };
   # Linux
   "MyBox" = mkLinux { hostname = "MyBox"; };
   ```

## Structure

```
.dotfiles/
├── flake.nix                        # Entry point
├── hosts/
│   ├── darwin/
│   │   ├── common/                  # Shared macOS config (casks, prefs, fonts)
│   │   └── razumikhin/              # Host-specific overrides
│   └── linux/
│       ├── common/                  # Shared Linux config
│       └── frank/                   # Host-specific overrides
├── home/                            # Shared home-manager modules
│   ├── shell.nix                    # zsh, starship, fzf, zoxide
│   ├── neovim.nix                   # Neovim + NvChad
│   ├── packages.nix                 # CLI tools
│   └── git.nix                      # Git config
└── config/
    └── nvim/                        # NvChad configuration
```

## License

Public domain ([Unlicense](LICENSE)).
