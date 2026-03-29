# Host: Razumikhin (macOS)
# Apply with: darwin-rebuild switch --flake .#Razumikhin
{ ... }: {
  imports = [
    ../common
  ];

  networking.hostName = "Razumikhin";
  system.primaryUser = "vlad.cuciureanu";

  # Host-specific overrides go here.
  # e.g. extra casks, different preferences, etc.
}
