{
  description = "Archi's home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
			pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."archismanmridha" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        ## Specify your home configuration modules here (for e.g. : the path to your home.nix).
        modules = [ ./home.nix ];

        ## (optional) You can use extraSpecialArgs to pass through arguments to home.nix.
      };
    };
}
