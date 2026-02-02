{
  home = {
    sessionVariables = {
      NIX_DIRENV_STRICT = "0";
      PASSWORD_STORE_DIR = "$HOME/dotfiles/.password-store";
      EDITOR = "nvim";
      LS_COLORS = "tokyonight";
    };

    shellAliases = {
      k = "kubectl";
      cd = "z";
      ls = "eza";
      cat = "bat";
      vi = "nvim";
      curl = "xh";
      htop = "btop";
      y = "yazi";
      pass = "gopass";
    };
  };

  programs = {
    zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "podman"
          "kubectl"
          "helm"
          "argocd"
          "terraform"
          "git"
          "gitignore"
          "colored-man-pages"
          "copyfile"
          "copypath"
          "redis-cli"
          "sudo"
          "tmux"
          "bun"
          "rust"
          "pass"
        ];
      };

      initContent = ''
        # Gets rid of this error :
        #
        # 	/nix/store/0pn1878v285l3nrfcagbb93bkkkbm811-oh-my-zsh-2024-10-01/share/oh-my-zsh/plugins/kube-ps1/kube-ps1.plugin.zsh:27: character not in range
        #
        # REFER : https://github.com/jonmosco/kube-ps1/issues/80#issuecomment-471517669.
        export LC_ALL="en_US.UTF-8";
        export LANG="en_US.UTF-8";

        # Start SSH Agent, if it isn't running already.
        if ! pgrep -u "$USER" ssh-agent > /dev/null; then
          eval "$(ssh-agent -s)"
        fi
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi

        # My wireguard config files are present at ~/.config/wireguard.
        wgup() {
          wg-quick up ~/.config/wireguard/$1.conf
        }
        wgdown() {
          wg-quick down ~/.config/wireguard/$1.conf
        }

        eval "$(direnv hook zsh)"
        eval "$(starship init zsh)"
      '';
    };
  };
}
