{
	homebrew = {
		enable = true;
		caskArgs.no_quarantine = true;
		global.brewfile = true;
		masApps = { };
		casks = [ "vlc" "discord" ];
		taps = [ ];
		brews = [ "orbstack" "pinentry-mac" "gnupg" "yubikey-personalization" ];
	};
}
