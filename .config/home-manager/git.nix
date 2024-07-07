{ pkgs, ... }:

{
	programs.git = {
		enable = true;

		userName = "Archisman Mridha";
		userEmail = "archismanmridha12345@gmail.com";

		extraConfig = {
			user = { signingKey = "~/.ssh/github"; };
			commit = { gpgsign = true; };
			gpg = { format = "ssh"; };

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
