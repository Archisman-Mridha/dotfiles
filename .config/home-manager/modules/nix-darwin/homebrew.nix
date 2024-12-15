{
	homebrew = {
		enable = true;
		caskArgs.no_quarantine = true;
		global.brewfile = true;
		masApps = { };
		casks = [ "vlc" "discord" "aviatrix-vpn-client" "homerow" "sourcetrail" "orbstack" ];
		taps = [ ];
		brews = [
			"pinentry-mac" "gnupg" "yubikey-personalization"
			"riscv64-elf-gdb"
		];

		onActivation = {
			cleanup = "zap";
			autoUpdate = true;
			upgrade = true;
		};
	};
}
