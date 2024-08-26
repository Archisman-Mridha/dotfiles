{ git, ... }:
{
	programs.git = {
		enable = true;

		userName = git.userName;
		userEmail = git.userEmail;

		extraConfig = {
			commit = { gpgsign = true; };
			/* gpg = { format = "ssh"; }; */
			user = { signingKey = git.signingKey; };

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
