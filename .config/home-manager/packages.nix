{ pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	home.packages= with pkgs; [
		bun
		rustup llvm
		go richgo golangci-lint
		zig zls
		luaformatter luajit
		terraform terraform-landscape terragrunt packer
		protobuf
		qemu nasm

		docker k3d k9s kubectl kubectx kustomize kubernetes-helm jsonnet jsonnet-bundler tanka
		cilium-cli kubeseal argocd trivy cosign

		neovim tmux bat btop atuin stern neofetch wget jq buf tree wget xh fd ripgrep eza lazydocker
		lazygit terminal-notifier gnupg gh yazi delta tldr thefuck stow
		fzf-zsh zsh-fzf-history-search zsh-fzf-tab

		vscode slack wezterm
	];

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
