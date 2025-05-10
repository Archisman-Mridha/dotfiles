{
  description = "Archi's nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
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
          ./modules/nix.nix
          ./modules/system.nix
          ./modules/trackpad.nix
          ./modules/finder.nix
          ./modules/dock.nix
          ./modules/window-manager.nix
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
