{
  home = {
    sessionPath = [ "/opt/homebrew/bin" "/opt/homebrew/sbin" ];

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
      cd = "z";
      ls = "eza";
      cat = "bat";
      vi = "nvim";
      htop = "btop";
      y = "yazi";
      pass = "gopass";
      git = "but";
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
        export PATH="$HOME/.local/bin:$PATH"

        eval "$(but completions zsh)"
        eval "$(direnv hook zsh)"
        eval "$(starship init zsh)"

        # NetBird wrapper to automate DNS configuration on macOS
        function netbird() {
            if [[ "$1" == "up" ]]; then
                command netbird "$@"
                local ec=$?

                if [[ $ec -eq 0 ]]; then
                    echo "NetBird connected. Configuring system DNS..."
                    sleep 2

                    local nb_ip=$(command netbird status --ipv4 2>/dev/null)

                    if [[ -n "$nb_ip" && "$nb_ip" != "N/A" ]]; then
                        local octets=$(echo "$nb_ip" | cut -d. -f1,2)
                        local dns_ip="''${octets}.255.254"

                        local interface=$(route -n get default 2>/dev/null | grep interface | awk '{print $2}')

                        if [[ -n "$interface" ]]; then
                            local service=$(networksetup -listnetworkserviceorder | grep -B 1 "Device: $interface" | head -n 1 | sed -E 's/^\([0-9]+\) //')

                            if [[ -n "$service" ]]; then
                                # Save current DNS settings if not already saved
                                if [[ ! -f ~/.netbird-prev-dns ]]; then
                                    local prev_dns=$(networksetup -getdnsservers "$service" 2>/dev/null | tr '\n' ' ' | sed 's/ $//')

                                    if [[ "$prev_dns" == *"There aren't any"* || -z "$prev_dns" ]]; then
                                        prev_dns="Empty"
                                    fi

                                    echo "$prev_dns" > ~/.netbird-prev-dns
                                fi

                                # Add NetBird DNS as primary and keep others as fallbacks
                                local fallbacks="8.8.8.8 8.8.4.4"
                                local saved_dns=$(cat ~/.netbird-prev-dns)

                                if [[ "$saved_dns" != "Empty" ]]; then
                                    fallbacks="$saved_dns"
                                fi

                                echo "Adding NetBird DNS ($dns_ip) to network service: $service"
                                sudo networksetup -setdnsservers "$service" "$dns_ip" $=fallbacks
                            fi
                        fi
                    else
                        echo "Warning: Could not retrieve NetBird IP. System DNS was not modified."
                    fi
                fi

                return $ec

            elif [[ "$1" == "down" ]]; then
                local interface=$(route -n get default 2>/dev/null | grep interface | awk '{print $2}')

                if [[ -n "$interface" ]]; then
                    local service=$(networksetup -listnetworkserviceorder | grep -B 1 "Device: $interface" | head -n 1 | sed -E 's/^\([0-9]+\) //')

                    if [[ -n "$service" ]]; then
                        local prev_dns="Empty"

                        if [[ -f ~/.netbird-prev-dns ]]; then
                            prev_dns=$(cat ~/.netbird-prev-dns)
                            rm -f ~/.netbird-prev-dns
                        fi

                        echo "Restoring previous DNS settings on interface: $service ($prev_dns)..."

                        if [[ "$prev_dns" == "Empty" ]]; then
                            sudo networksetup -setdnsservers "$service" Empty
                        else
                            sudo networksetup -setdnsservers "$service" $=prev_dns
                        fi
                    fi
                fi

                command netbird "$@"

            else
                command netbird "$@"
            fi
        }
      '';
    };
  };
}
