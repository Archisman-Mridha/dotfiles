{ pkgs, stdenv, ... }:
{
	/*
		The configuration of the Nix Packages collection. (For details, see the Nixpkgs documentation.)
		It allows you to set package configuration options.
	*/
	nixpkgs.config.allowUnfree = true;

	home.packages= with pkgs; [
		bun
		rustup llvm
		go richgo golangci-lint
		zig zls
		luaformatter luajit
		terraform terraform-landscape terragrunt packer
		protobuf
		wabt
		qemu nasm

		docker k3d k9s kubectl kubectx kustomize kubernetes-helm jsonnet jsonnet-bundler tanka
		cilium-cli kubeseal argocd trivy cosign

		neovim tmux bat btop atuin stern neofetch wget jq buf tree wget xh fd ripgrep eza lazydocker
		lazygit gnupg gh yazi delta tldr thefuck stow
		fzf-zsh zsh-fzf-history-search zsh-fzf-tab

		vscode slack wezterm
	] ++ (
		if system == "aarch64-darwin" then
			let
				protonvpn = pkgs.stdenv.mkDerivation rec {
					pname = "protonvpn";
					version = "4.3.0";

					src = pkgs.fetchurl {
						url = "https://protonvpn.com/download/ProtonVPN_mac_v4.3.0.dmg";
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
						url = "https://github.com/waydabber/BetterDisplay/releases/download/v2.3.9/BetterDisplay-v2.3.9.dmg";
						sha256 = "sha256-PuBD/ViTqzVO+8TJqSKVohs2XlWvNMxkYSJVh4t0ZyI=";
					};

					nativeBuildInputs = [ pkgs.undmg ];

					sourceRoot = ".";

					installPhase = ''
						mkdir -p $out/Applications
						cp -r BetterDisplay.app $out/Applications/
					'';
				};
			in
			[
				colima
				terminal-notifier
				better-display protonvpn
			]
		else
			[ protonvpn-cli ]
	);

	programs = {
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
