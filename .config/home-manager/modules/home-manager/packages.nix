{
  pkgs,
  system,
  zen-browser,
  ...
}:
{
  /*
    The configuration of the Nix Packages collection. (For details, see the Nixpkgs documentation.)
    It allows you to set package configuration options.
  */
  nixpkgs.config.allowUnfree = true;

  home.packages =
    with pkgs;
    [
      # Programming Languages related.
      go_1_24
      llvm
      rustup
      zig
      zls
      bun
      nodejs_22
      biome
      luaformatter
      luajit
      luarocks
      ruff
      pyright
      hyprls
      cmake
      ccache
      nixfmt-rfc-style

      # Kubernetes and CloudNative related.
      k3d
      kubectl
      kubectx
      kustomize
      kubernetes-helm
      kubeseal
      docker-compose
      lazydocker
      kops
      awscli2
      saml2aws
      aws-nuke
      hcloud
      cue
      dive
      ansible

      # For managing terminal prompt.
      starship

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
      teleport

      # For fuzzy finding.
      fzf
      fzf-zsh
      zsh-fzf-history-search
      zsh-fzf-tab

      neovim # Editor
      yazi # File manager
      tmux # Multiplexer
      pass # Password manager

      # Git related.
      lazygit
      git
      delta

      # GPG related.
      gnupg

      # Miscalleneous CLI tools.
      bat
      btop
      atuin
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
      mkalias
      direnv

      # Desktop Apps
      wezterm
      vscode
      slack
      drawio
      qemu
      postman
    ]
    ++ (
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
        in
        [
          # GPG related.
          yubikey-personalization
          pinentry_mac

          # Desktop Apps
          terminal-notifier
          protonvpn
          better-display
          raycast
        ]
      else
        [
          # TODO : This isn't working. Shift to WireGuard.
          # protonvpn-cli

          docker

          # Wayland Compositor
          xdg-desktop-portal-hyprland
          hyprland
          waybar
          rofi
          hyprpaper
          hyprcursor
          hyprlock
          hypridle
          waypipe

          # Desktop Apps
          zen-browser.packages."${system}".specific
          mattermost-desktop
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
      icons = "auto";
      git = true;
      extraOptions = [ "--group-directories-first" ];
    };

    zoxide.enable = true;

    home-manager = {
      enable = true;
    };
  };
}
