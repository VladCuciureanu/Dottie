{ ... }: {
  # macOS system preferences (declarative)
  # Add specific defaults as needed. The old .macos script had everything
  # commented out, so this starts minimal. Uncomment/add as desired.

  system.defaults = {
    # Dock
    dock = {
      autohide = false;
      show-recents = false;
      mru-spaces = false;
      minimize-to-application = true;
    };

    # Finder
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
    };

    # Global
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Set to 'Hyper (Shift + Option + Control + Command) + Space (ASCII 32, virtual keycode 49)' for Spotlight Search
          "64" = {
            enabled = true;
            value = {
              parameters = [32 49 1966080];
              type = "standard";
            };
          };

          # Disable 'Cmd + Option + Space' for Finder search window
          "65" = {
            enabled = false;
          };
        };
      };
    };
	};
}
