{
  pkgs,
  pkgs-26_05,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Programming languages related.
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
    # Tanka cannot resolve OCI Helm repository URLs when driving Helm 4, so this stays on the
    # Helm 3 build from nixpkgs 26.05.
    pkgs-26_05.kubernetes-helm
    kubeseal
    kubecolor
    jsonnet
    jsonnet-bundler
    gojsontoyaml
    tanka
    teleport
    cilium-cli
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
    netbird

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

    # YubiKey related.
    yubikey-personalization

    # Nix related.
    nh
    zsh-nix-shell

    # Miscellaneous CLI tools.
    bat
    btop
    eza
    fd
    jq
    yq
    fastfetch
    ripgrep
    stow
    tldr
    unzip
    gh

    # Desktop apps.
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

    zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      darwin.packageMode = "signed";

      profiles.default = {
        id = 0;

        settings = {
          "zen.welcome-screen.seen" = true;

          "zen.view.compact" = true;
          "zen.view.compact.hide-both" = true;
          "zen.urlbar.behavior" = "float";

          "font.name.serif.x-western" = "SF Pro";
          "font.name.sans-serif.x-western" = "SF Pro";
          "font.name.monospace.x-western" = "Custom LiterationMono Nerd Font";
          "browser.display.use_document_fonts" = 0;

          "zen.workspaces.continue-where-left-off" = true;
        };

        presets.betterfox.enable = true;
      };
    };
  };
}
