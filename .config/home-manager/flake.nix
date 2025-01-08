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

		zen-browser.url = "github:MarceColl/zen-browser-flake";

		ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, zen-browser, ghostty }:
    let
			system = builtins.currentSystem;
			/* system = "aarch64-darwin"; */

			macosConfig = import ./macos.config.nix;
			archLinuxConfig = import ./archlinux.config.nix;
			config =
				if system == "aarch64-darwin" then macosConfig else archLinuxConfig;

			inherit (config) user device git;

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
					inherit user git system zen-browser ghostty;
				};

				/* Specify your home configuration modules here (for e.g. : the path to your home.nix). */
				modules = [ ./modules/home-manager ];
			};

			darwinConfigurations = if system == "x86_64-darwin" || system == "aarch64-darwin" then {
        "${device}" = nix-darwin.lib.darwinSystem {
          inherit pkgs system;

          modules = [ ./modules/nix-darwin ];
        };
      } else {};
		};
}
