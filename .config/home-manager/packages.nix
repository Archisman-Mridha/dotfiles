{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages= with pkgs; [
    bun
    rustup llvm
    go richgo golangci-lint
    luaformatter luajit
    terraform terraform-landscape terragrunt packer
    protobuf

    # Kubernetes tools.
    k3d k9s kubectl kubectx kustomize kubernetes-helm jsonnet jsonnet-bundler tanka cilium-cli
    kubeseal

    # Supplychain security.
    trivy cosign

    # Terminal utilities.
    neovim tmux bat gotop stern neofetch wget jq buf tree wget xh fd ripgrep eza
    terminal-notifier stow gnupg pinentry_mac gh
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
