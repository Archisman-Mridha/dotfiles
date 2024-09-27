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
					/* "docker" "docker-compose" */
					"git" "gitignore" "kube-ps1" "kubectl" "helm" "argocd" "terraform"
					"bun" "colored-man-pages" "copyfile" "copypath" "redis-cli" "rust" "sudo" "tmux"
				];
			};

			initExtra = ''
				PROMPT='$(kube_ps1) '$PROMPT
				precmd() { echo; }

				eval $(thefuck --alias)

				export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

        PATH=$PATH:$HOME/.docker/cli-plugins
			'';
		};
	};
}
