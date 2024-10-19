{
	homebrew = {
		enable = true;
		caskArgs.no_quarantine = true;
		global.brewfile = true;
		masApps = { };
		casks = [ "vlc" "discord" ];
		taps = [ ];
		brews = [ "pinentry-mac" "gnupg" "yubikey-personalization" "orbstack" ];

		onActivation = {
			cleanup = "zap";
			autoUpdate = true;
			upgrade = true;
		};
	};
}
