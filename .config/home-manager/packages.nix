{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages= with pkgs; [
    bun nodejs_21
    rustup llvm
    go richgo golangci-lint
    zig zls
    luaformatter luajit
    terraform terraform-landscape terragrunt packer
    protobuf
    yamllint
    qemu nasm

    # Kubernetes tools.
    k3d k9s kubectl kubectx kustomize kubernetes-helm jsonnet jsonnet-bundler tanka cilium-cli
    kubeseal argocd

    # Supplychain security.
    trivy cosign

    # Terminal utilities.
    neovim tmux bat btop atuin stern neofetch wget jq buf tree wget xh fd ripgrep eza
    terminal-notifier stow gnupg pinentry_mac gh yazi delta
  ];

  programs = {
    eza = {
      enable = true;
      icons = true;
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    zoxide = {
      enable = true;
    };

    home-manager.enable = true;
  };
}
