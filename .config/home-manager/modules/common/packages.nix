{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Programming languages related.
    go
    rustup
    cmake
    nodejs
    bun
    biome
    nixfmt-rfc-style
    luaformatter
    luajit
    luarocks
    hyprls

    # Kubernetes and CloudNative related.
    k3d
    kubectx
    kubeswitch
    kubernetes-helm
    kubeseal
    teleport
    velero
    cilium-cli
    argocd
    saml2aws
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

    # Fuzzy searching related.
    fzf
    fzf-zsh
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
    lazygit
    delta
    jujutsu
    lazyjj
    git-crypt

    # GPG related.
    gnupg

    # Nix related.
    cachix
    nh

    # Miscellaneous CLI tools.
    bat
    btop
    carapace
    eza
    fd
    jq
    mkalias
    neofetch
    qemu
    ripgrep
    stern
    stow
    tldr
    unzip

    # Desktop apps.
    wezterm
    vscode
    slack
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
