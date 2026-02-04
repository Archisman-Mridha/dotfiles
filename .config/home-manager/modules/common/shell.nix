{
  home = {
    sessionVariables = {
      NIX_DIRENV_STRICT = "0";
      PASSWORD_STORE_DIR = "$HOME/dotfiles/.password-store";
      EDITOR = "nvim";
      LS_COLORS = "tokyonight";

      /*
        Gets rid of this error :

          /nix/store/0pn1878v285l3nrfcagbb93bkkkbm811-oh-my-zsh-2024-10-01/share/oh-my-zsh/plugins/kube-ps1/kube-ps1.plugin.zsh:27: character not in range

        REFER : https://github.com/jonmosco/kube-ps1/issues/80#issuecomment-471517669.
      */
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };

    shellAliases = {
      k = "kubectl";
      cd = "z";
      ls = "eza";
      cat = "bat";
      vi = "nvim";
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
        eval "$(direnv hook zsh)"
        eval "$(starship init zsh)"
      '';
    };
  };
}
