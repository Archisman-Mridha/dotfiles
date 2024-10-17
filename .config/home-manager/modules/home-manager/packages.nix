{ pkgs, ... }:
let
	clusterawsadm = pkgs.stdenv.mkDerivation rec {
		pname = "clusterawsadm";
    version = "v2.5.2";

    src = pkgs.fetchurl {
      url =
				"https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${version}/" + (
					if pkgs.stdenv.isDarwin then
        		"clusterawsadm-darwin-arm64"
					else
						"clusterawsadm-linux-amd64"
				);

      sha256 = "sha256-FsMtnQQcv5yIrBfNMh0Kq1Lqnh7V0BuggvksSaLLZoo=";
    };

    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/clusterawsadm
      chmod +x $out/bin/clusterawsadm
    '';
	};

	fontsDir =
		if pkgs.stdenv.isDarwin then
    	"~/Library/Fonts"
  	else
    	"~/.local/share/fonts";
in {
	/*
		The configuration of the Nix Packages collection. (For details, see the Nixpkgs documentation.)
		It allows you to set package configuration options.
	*/
	nixpkgs.config.allowUnfree = true;

	home.packages= with pkgs; [
		go richgo golangci-lint mockgen sqlc
		luaformatter luajit luarocks
		terraform
		protobuf buf
		ruff pyright

		k3d kubectl kubectx kustomize kubernetes-helm operator-sdk kubeseal
    jsonnet-bundler jsonnet tanka

		tmux bat btop atuin stern neofetch jq xh fd ripgrep yazi eza lazygit delta thefuck neovim tldr
    stow
		fzf-zsh zsh-fzf-history-search zsh-fzf-tab

		vscode slack wezterm drawio
	] ++ (
		if system == "aarch64-darwin" then
			let
				protonvpn = pkgs.stdenv.mkDerivation rec {
					pname = "protonvpn";
					version = "v4.3.0";

					src = pkgs.fetchurl {
						url = "https://protonvpn.com/download/ProtonVPN_mac_${version}.dmg";
						sha256 = "sha256-ZXSSDiJX8xmOcus+uINZo13RJunR0ud2FUvg6/tKfdA=";
					};

					nativeBuildInputs = [ pkgs.undmg ];
					sourceRoot = ".";
					installPhase = ''
						mkdir -p $out/Applications
						cp -r ProtonVPN.app $out/Applications/
					'';
				};
				better-display = pkgs.stdenv.mkDerivation rec {
					pname = "better-display";
					version = "v2.3.9";
					src = pkgs.fetchurl {
						url = "https://github.com/waydabber/BetterDisplay/releases/download/${version}/BetterDisplay-${version}.dmg";
						sha256 = "sha256-PuBD/ViTqzVO+8TJqSKVohs2XlWvNMxkYSJVh4t0ZyI=";
					};

					nativeBuildInputs = [ pkgs.undmg ];
					sourceRoot = ".";
					installPhase = ''
						mkdir -p $out/Applications
						cp -r BetterDisplay.app $out/Applications/
					'';
				};
			in [
        cmake ccache
        gleam erlang
				bun
				rustup llvm
				zig zls
				wabt wasmedge
				qemu nasm

				yabai terminal-notifier better-display protonvpn
			]
		else [ protonvpn-cli ]
	);

	programs = {
		k9s = {
			enable = true;
			settings = {
				k9s = {
					ui = {
						headless = true;
						logoless = true;
						crumbsless = true;
						skin = "transparent";
					};
				};
			};
		};

		eza = {
			enable = true;
			icons = true;
			git = true;
			extraOptions = [ "--group-directories-first" ];
		};

		zoxide.enable = true;

		home-manager.enable = true;
	};
}
