{
  description = "Archi's nix-darwin configuration";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";

    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      inputs,
    }:
    let
      system = "aarch64-darwin";
      device = "Archismans-MacBook-Air";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      darwinConfigurations."${device}" = nix-darwin.lib.darwinSystem {
        inherit pkgs system;

        modules = [
          inputs.determinate.darwinModules.default

          ./modules/nix.nix
          ./modules/system.nix
          ./modules/trackpad.nix
          ./modules/finder.nix
          ./modules/dock.nix
          ./modules/homebrew.nix
        ];

        /*
          I didn't find any option to configure :

            1. Display scale.
            2. Keyboard backlight brightness.
            3. Window tiling (introduced in MacOS Sequoia).
        */
      };
    };
}
