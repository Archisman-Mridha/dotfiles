{ pkgs, ... }:
{
	home = {
		sessionVariables = {
			EDITOR = "nvim";
		};

		shellAliases = {
			k = "kubectl";
			cd = "z";
			ls = "eza";
			cat = "bat";
			vi = "nvim";
			curl = "xh";
			htop = "btop";
			compose = "podman-compose";
		} // (
			if pkgs.stdenv.isDarwin then {
				code = "~/Applications/Home\ Manager\ Apps/Visual\ Studio\ Code.app/Contents/MacOS/Electron";
			}
			else {}
		);
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
					"git" "gitignore" "docker" "docker-compose" "kube-ps1" "kubectl" "helm" "argocd" "terraform"
					"bun" "colored-man-pages" "copyfile" "copypath" "redis-cli" "rust" "sudo" "tmux"
				];
			};

			initExtra = ''
				PROMPT='$(kube_ps1) '$PROMPT
				precmd() { echo; }

				eval $(thefuck --alias)

				export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

				if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
					source ~/.gnupg/.gpg-agent-info
					export GPG_AGENT_INFO
				else
					eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
				fi

				# MacOS specific
				export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
			'';
		};
	};
}
