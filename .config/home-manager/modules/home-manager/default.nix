{ user, pkgs, ... }:
{
	home = {
		username = user;
		homeDirectory =
			if pkgs.system == "aarch64-darwin" then
				"/Users/${user}"
			else
				"/home/${user}";

		/*
			This value determines the home-manager release that your configuration is compatible with.
			This helps avoid breakage when a new home-manager release introduces backwards incompatible
			changes. You should not change this value, even if you update home-manager. If you do want to
			update the value, then make sure to first check the home-manager release notes.
		*/
		stateVersion = "24.05";
	};

	imports = [
		./editorconfig.nix
		./git.nix
		./packages.nix
		./shell.nix
		./tmux.nix
	];
}
