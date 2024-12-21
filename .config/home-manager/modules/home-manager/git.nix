{ git, system, ... }:
{
	programs.git = {
		enable = true;

		userName = git.userName;
		userEmail = git.userEmail;

		extraConfig = {
			commit = { gpgsign = true; };

			user = { signingKey = git.signingKey; };

			/*
				If git.signingKey is a path (must be absolute) which exists, then we assume that an SSH key
				will be used for commit signing.
				Otherwise, we assume that git.signingKey is a GPG key id.	
			*/
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
}
