{
  description = "Archi's Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin }:
    let
			config = import ./config.nix;
			inherit (config) system user device git;

			pkgs = import nixpkgs {
				inherit system;

				config = {
					/* Try compiling packages which are marked as unsupported for the given system. */
					allowUnsupportedSystem = true;
				};
			};
    in {
			homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;

				/* (optional) You can use extraSpecialArgs to pass through arguments to home.nix. */
				extraSpecialArgs = {
					inherit user git;
				};

				/* Specify your home configuration modules here (for e.g. : the path to your home.nix). */
				modules = [ ./modules/home-manager ];
			};

			darwinConfigurations."${device}" = nix-darwin.lib.darwinSystem {
				inherit pkgs system;

				modules = [ ./modules/nix-darwin ];
			};
		};
}
