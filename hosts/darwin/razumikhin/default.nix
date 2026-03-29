# Host: Razumikhin (macOS)
# Apply with: darwin-rebuild switch --flake .#Razumikhin
{ ... }: {
  imports = [
    ../common
  ];

  networking.hostName = "Razumikhin";
  system.primaryUser = "vlad.cuciureanu";

  homebrew.casks = [
    "discord"
    "moonlight"
    "steam"
    "unity-hub"
  ];
}
