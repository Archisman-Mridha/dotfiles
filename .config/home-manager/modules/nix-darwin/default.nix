{ ... }:
{
	services.nix-daemon.enable = true;
	nix = {
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
      /* Whether to autohide the menu bar. (No ption to set it to "never") */
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
		/* ./window-manager.nix */
	];

	/*
		I didn't find any option to configure :

		1. Display scale.
		2. Keyboard backlight brightness.
		3. Window tiling (introduced in MacOS Sequoia).
	*/
}
