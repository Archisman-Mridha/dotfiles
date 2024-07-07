{ config, pkgs, ... }:

{
	home = {
		username = "archismanmridha";
		homeDirectory = "/Users/archismanmridha";

		# This value determines the home-manager release that your configuration is compatible with.
		# This helps avoid breakage when a new home-manager release introduces backwards incompatible
		# changes. You should not change this value, even if you update home-manager. If you do want to
		# update the value, then make sure to first check the home-manager release notes.
		stateVersion = "23.11";
	};

	imports = [
		./shell.nix
		./packages.nix
		./tmux.nix
		./editorconfig.nix
		./git.nix
	];
}
