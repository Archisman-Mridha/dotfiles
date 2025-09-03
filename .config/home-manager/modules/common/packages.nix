{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Programming Languages related.
    go
    rustup
    cmake
    nodejs_23
    bun
    biome
    nixfmt-rfc-style
    luaformatter
    luajit
    luarocks
    hyprls

    # Kubernetes and CloudNative related.
    # podman
    # podman-compose
    # podman-tui
    k3d
    kubectx
    kubectl
    kubernetes-helm
    kubeseal
    teleport
    saml2aws
    awscli2
    aws-nuke
    hcloud
    velero
    cilium-cli
    argocd

    # Networking related.
    curl
    wget
    tshark
    netcat-gnu
    oha
    dig
    openssh
    assh
    xh
    wireguard-tools

    # For fuzzy finding.
    fzf
    fzf-zsh
    zsh-fzf-history-search
    zsh-fzf-tab

    # Terminal prompt manager.
    starship
    # Terminal Multiplexer
    tmux
    # Editor
    neovim
    imagemagick
    # File manager
    yazi
    # Password manager
    gopass

    # Git related.
    git
    lazygit
    delta
    jujutsu
    lazyjj
    git-crypt

    # GPG related.
    gnupg

    # Miscalleneous CLI tools.
    bat
    btop
    stern
    neofetch
    jq
    fd
    ripgrep
    eza
    thefuck
    tldr
    stow
    unzip
    carapace
    cachix

    # Desktop Apps
    wezterm
    vscode
    drawio
    qemu
    slack

    # To install radio-active.
    ffmpeg
    pipx
  ];

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      icons = "auto";
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    zoxide.enable = true;

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
  };
}
