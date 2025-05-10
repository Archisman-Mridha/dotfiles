{
  description = "Archi's Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
    }:
    let
      devices = [
        {
          name = "Archismans-MacBook-Air";
          system = "aarch64-darwin";
          user = "archismanmridha";
        }
        {
          name = "archlinux";
          system = "x86_64-linux";
          user = "archi";
        }
      ];
    in
    {
      homeConfigurations = builtins.listToAttrs (
        builtins.map (
          device:
          let
            system = device.system;
            user = device.user;
            pkgs = import nixpkgs { inherit system; };
          in
          {
            name = "${user}@${device.name}";
            value = home-manager.lib.homeManagerConfiguration {
              inherit pkgs;

              extraSpecialArgs = {
                inherit user zen-browser;
              };

              modules = [
                ./modules/common/home.nix
                ./modules/common/editorconfig.nix
                ./modules/common/fonts.nix
                ./modules/common/git.nix
                ./modules/common/gpg.nix
                ./modules/common/packages.nix
                ./modules/common/shell.nix
                ./modules/common/ssh.nix
                ./modules/common/tmux.nix
              ] ++ (if system == "aarch64-darwin" then [ ./modules/macos.nix ] else [ ./modules/archlinux.nix ]);
            };
          }
        ) devices
      );
    };
}
