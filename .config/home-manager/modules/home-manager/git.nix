{ git, ... }:
let
	/*
		Personally, I use an SSH key to both : sign my commits and authenticate against Github.

		If git.signingKey is an 8 or 16 character hexadecimal string, then I assume that git.signingKey
		is a GPG key id. Otherwise, I assume that it's a valid absolute path to the SSH key being used
		for commit signing and authentication against Github.
	*/
	isGPGKey = str: 
		builtins.match "^(0x)?[0-9A-Fa-f]{8,16}$" str != null;
in {
	programs.git = {
		enable = true;

		userName = git.userName;
		userEmail = git.userEmail;

		extraConfig = {
			commit = { gpgsign = true; };

			user = { signingKey = git.signingKey; };

			gpg =
				if isGPGKey git.signingKey then {}
				else { format = "ssh"; };

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
