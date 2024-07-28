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

	/* To avoid a logout/login cycle */
	system.activationScripts.postUserActivation.text =
		"/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u";

	imports = [
		./dock.nix
		./finder.nix
	];
}
