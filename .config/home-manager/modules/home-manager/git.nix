{ pkgs, git, system, ... }:
let
	/*
		I use an SSH key to both : sign my commits and authenticate against Github.

		If git.signingKey is an absolute path that exists, then I assume that an SSH key will be used
		to sign commits and authenticate against Github.

		Otherwise, I assume that git.signingKey is a GPG key id.	
	*/
	usingSSHSigningAndAuthenticationKey = builtins.pathExists git.signingKey;
in {
	programs.git = {
		enable = true;

		userName = git.userName;
		userEmail = git.userEmail;

		extraConfig = {
			commit = { gpgsign = true; };

			user = { signingKey = git.signingKey; };

			gpg =
				if builtins.pathExists git.signingKey then { format = "ssh"; }
				else {};

			push = { autoSetupRemote = true; };
		};

		delta = {
			enable = true;
			options = {
				navigate = true;
				dark = true;
			};
		};
	};

	programs.ssh = {
		enable = true;
		package = pkgs.openssh;

		matchBlocks = {
			"github.com" = if usingSSHSigningAndAuthenticationKey then {
				hostname = "github.com";
				identityFile = git.signingKey;
			} else {};
		};
	};
}
