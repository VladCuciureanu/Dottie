{
  description = "Cross-platform dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nix-darwin, home-manager, ... }: let
    username = "vlad.cuciureanu";

    # Helper: create a nix-darwin host with home-manager
    mkDarwin = { hostname, system ? "aarch64-darwin", extraModules ? [] }:
      nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./hosts/darwin/${nixpkgs.lib.toLower hostname}
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = {
              imports = [ ./home ];
              home.username = username;
              home.homeDirectory = "/Users/${username}";
            };
          }
          {
            users.users.${username}.home = "/Users/${username}";
          }
        ] ++ extraModules;
      };

    # Helper: create a standalone home-manager config for Linux
    mkLinux = { hostname, system ? "x86_64-linux", extraModules ? [] }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./hosts/linux/${nixpkgs.lib.toLower hostname}
          ./home
          {
            home.username = username;
            home.homeDirectory = "/home/${username}";
          }
        ] ++ extraModules;
      };
  in {
    # ── macOS hosts ──────────────────────────────────────────────
    # darwin-rebuild switch --flake .#<hostname>
    darwinConfigurations = {
      "Razumikhin" = mkDarwin { hostname = "Razumikhin"; };
      # Add more darwin hosts here:
      # "AnotherMac" = mkDarwin { hostname = "AnotherMac"; };
    };

    # ── Linux hosts ──────────────────────────────────────────────
    # home-manager switch --flake .#<hostname>
    homeConfigurations = {
      "Frank" = mkLinux { hostname = "Frank"; };
      # Add more linux hosts here:
      # "AnotherBox" = mkLinux { hostname = "AnotherBox"; system = "aarch64-linux"; };
    };
  };
}
