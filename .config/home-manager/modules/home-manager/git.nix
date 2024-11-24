{ git, system, ... }:
{
	programs.git = {
		enable = true;

		userName = git.userName;
		userEmail = git.userEmail;

		extraConfig = {
			commit = { gpgsign = true; };
			gpg =
				if system == "aarch64-darwin" then{ format = "ssh"; }
				else {};
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
