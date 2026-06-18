{
  description = "Archi's nix-darwin configuration";

  inputs = {
    determinate.url = "github:DeterminateSystems/determinate";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      determinate,
      ...
    }:
    let
      system = "aarch64-darwin";
      device = "Archismans-MacBook-Air";

      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      darwinConfigurations."${device}" = nix-darwin.lib.darwinSystem {
        inherit system pkgs;

        modules = [
          determinate.darwinModules.default

          ./modules/nix.nix
          ./modules/system.nix
          ./modules/trackpad.nix
          ./modules/finder.nix
          ./modules/dock.nix
          ./modules/homebrew.nix

          /*
            I didn't find any option to configure :

              1. Display scale.
              2. Keyboard backlight brightness.
              3. Window tiling (introduced in MacOS Sequoia).
          */
        ];
      };
    };
}
