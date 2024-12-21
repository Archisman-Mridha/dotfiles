{ pkgs, ... }:
{
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
		hyprls

		k3d kubectl kubectx kustomize kubernetes-helm operator-sdk kubeseal teleport
    jsonnet-bundler jsonnet tanka lazydocker kops awscli2 hcloud wireguard-tools

		tmux bat btop atuin stern neofetch jq xh fd ripgrep yazi eza lazygit delta thefuck tldr git
    stow neovim unzip pass
		curl wget tshark netcat-gnu oha
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
				bun nodejs_22
				rustup llvm
				zig zls

				wabt wasmedge
				qemu nasm

				mkalias terminal-notifier protonvpn
				better-display yabai
			]
		else [
			xdg-desktop-portal-hyprland hyprland waybar rofi hyprpaper hyprcursor hyprlock hypridle
			waypipe
			protonvpn-cli mattermost-desktop

			podman podman-compose
		]
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

		home-manager = {
			enable = true;
		};
	};
}
