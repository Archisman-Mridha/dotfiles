{
	homebrew = {
		enable = true;
		caskArgs.no_quarantine = true;
		global.brewfile = true;
		masApps = { };
		casks = [ "orbstack" ];
		taps = [ ];
		brews = [ "k3d" ];
	};
}
