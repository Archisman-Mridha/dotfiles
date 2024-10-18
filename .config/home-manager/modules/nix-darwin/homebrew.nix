{
	homebrew = {
		enable = true;
		caskArgs.no_quarantine = true;
		global.brewfile = true;
		masApps = { };
		casks = [ "vlc" "discord" "orbstack" ];
		taps = [ ];
		brews = [ "pinentry-mac" "gnupg" "yubikey-personalization" ];

		onActivation = {
			cleanup = "zap";
			autoUpdate = true;
			upgrade = true;
		};
	};
}
