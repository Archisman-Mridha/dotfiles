{
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Programming languages related.
    nodejs_26
    bun
    go
    gopls
    rustup
    cmake
    nixfmt
    luaformatter
    luajit
    luarocks
    python3

    # Kubernetes and CloudNative related.
    k3d
    kubectx
    kubeswitch
    kubernetes-helm
    kubeseal
    kubecolor
    krew
    jsonnet
    jsonnet-bundler
    gojsontoyaml
    teleport
    cilium-cli
    harbor-cli
    argocd
    velero
    awscli2
    aws-nuke
    hcloud

    # Networking related.
    curl
    wget
    tshark
    netcat-gnu
    dig
    openssh
    assh
    wireguard-tools
    # netbird

    # Fuzzy searching related.
    fzf
    fzf-zsh-plugin
    zsh-fzf-history-search
    zsh-fzf-tab

    # Terminal management related.
    starship
    tmux
    neovim
    yazi
    gopass

    # Git related.
    git
    git-crypt

    # GPG related.
    gnupg

    # Nix related.
    cachix
    nh
    zsh-nix-shell

    # Miscellaneous CLI tools.
    bat
    btop
    carapace
    eza
    fd
    jq
    mkalias
    fastfetch
    qemu
    ripgrep
    stern
    stow
    tldr
    unzip

    # Desktop apps.
    # mattermost-desktop
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
