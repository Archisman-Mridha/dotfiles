{ ... }:
{
	/* Auto upgrade nix packages and the the daemon service */
	services.nix-daemon = {
		enable = true;
		enableSocketListener = true;
	};
	nix = {
		optimise = {
			automatic = true;
		};
		gc = {
			/* Automatically run the garbage collector at a specific time. */
			automatic = true;
			interval = { Hour = 23; };
			user = "archismanmridha";
		};
	};

  system = {
    /*
      To avoid a logout/login cycle.
      NOTE : Doesn't reflect all the changes.
    */
    activationScripts.postUserActivation.text =
      "/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u";

    defaults.NSGlobalDomain = {
			/* Enable dark mode. */
			AppleInterfaceStyle = "Dark";

			/* Whether to enable automatic capitalization. */
			NSAutomaticCapitalizationEnabled = false;

			/* Whether to enable smart dash substitution. */
			NSAutomaticDashSubstitutionEnabled = false;

			/* Whether to enable smart period substitution. */
			NSAutomaticPeriodSubstitutionEnabled = false;

			/* Whether to enable smart quote substitution. */
			NSAutomaticQuoteSubstitutionEnabled = false;

			/* Whether to enable automatic spelling correction. */
			NSAutomaticSpellingCorrectionEnabled = false;

			/* Whether to animate opening and closing of windows and popovers. */
			NSAutomaticWindowAnimationsEnabled = true;

			/* Whether to disable the automatic termination of inactive apps. */
			NSDisableAutomaticTermination = true;

			/* Whether to save new documents to iCloud by default. */
			NSDocumentSaveNewDocumentsToCloud = false;

			/* Whether to enable smooth scrolling. */
			NSScrollAnimationEnabled = true;

      /* Whether to autohide the menu bar. (No option to set it to "never") */
      _HIHideMenuBar = false;

      /*
        If you press and hold certain keyboard keys when in a text area, the key’s character begins to
        repeat. For example, the Delete key continues to remove text for as long as you hold it down.
        This sets how fast it repeats once it starts.
      */
      KeyRepeat = 5;
    };

    stateVersion = 5;
  };


	imports = [
		./dock.nix
		./finder.nix
		./trackpad.nix
		./homebrew.nix
		./window-manager.nix
	];

	/*
		I didn't find any option to configure :

		1. Display scale.
		2. Keyboard backlight brightness.
		3. Window tiling (introduced in MacOS Sequoia).
	*/
}
