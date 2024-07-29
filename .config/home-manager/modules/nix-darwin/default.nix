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

	/*
		To avoid a logout/login cycle.
		NOTE : Doesn't reflect all the changes.
	*/
	system.activationScripts.postUserActivation.text =
		"/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u";

	/* Whether to autohide the menu bar. (No ption to set it to "never") */
	system.defaults.NSGlobalDomain._HIHideMenuBar = false;

	imports = [
		./dock.nix
		./finder.nix
		./trackpad.nix
	];

	/*
		I didn't find any option to configure :

		1. Display scale.
		2. Keyboard backlight brightness.
		3. Window tiling (introduced in MacOS Sequoia).
	*/
}
