{ pkgs, ... }: {
  imports = [
    ./preferences.nix
  ];

  # Nix settings — nix.enable = false because Determinate manages the daemon
  nix.enable = false;
  nixpkgs.config.allowUnfree = true;

  # System packages (macOS only)
  environment.systemPackages = with pkgs; [
    curl
  ];

  # Let nix-darwin manage Homebrew for GUI apps (casks)
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "1password"
      "adobe-acrobat-reader"
      "arc"
      "claude"
      "dbeaver-community"
      "ngrok"
      "orbstack"
      "postman"
      "raycast"
      "sanesidebuttons"
      "slack"
      "spotify"
      "the-unarchiver"
      "visual-studio-code"
      "warp"
      "whatsapp"
      "zoom"
    ];
    brews = [
      "blueutil"
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];

  # System settings
  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility
  system.stateVersion = 6;
}
