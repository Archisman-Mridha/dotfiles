{ pkgs, git, system, ... }:
let
	/*
		Personally, I use an SSH key to both : sign my commits and authenticate against Github.

		If git.signingKey is an 8 or 16 character hexadecimal string, then I assume that git.signingKey
		is a GPG key id. Otherwise, I assume that it's a valid absolute path to the SSH key being used
		for commit signing and authentication against Github.

		TODO : fix
	*/
	isGPGKey = str: 
		builtins.match "^(0x)?[0-9A-Fa-f]{8,16}$" str != null;
in {
	programs.ssh = {
		enable = true;
		package = pkgs.openssh;

		matchBlocks = {
			"github.com" =
				if isGPGKey git.signingKey then {}
				else {
					hostname = "github.com";
					identityFile = git.signingKey;
				};

			"gitea.obmondo.com" = {
				hostname = "gitea.obmondo.com";
				port = 2223;
			};
		};

		includes = [ "assh.config" "~/.orbstack/ssh/config" ];
	};
}
