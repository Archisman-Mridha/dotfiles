{
	homebrew = {
		enable = true;
		caskArgs.no_quarantine = true;
		global.brewfile = true;
		masApps = { };
		casks = [ "vlc" "discord" "aviatrix-vpn-client" "homerow" ];
		taps = [ ];
		brews = [
			"pinentry-mac" "gnupg" "yubikey-personalization"
			"docker" "docker-compose" "docker-credential-helper"
			"riscv64-elf-gdb"
		];

		onActivation = {
			cleanup = "zap";
			autoUpdate = true;
			upgrade = true;
		};
	};
}
