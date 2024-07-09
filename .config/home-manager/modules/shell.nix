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
			code = "~/Applications/Home\ Manager\ Apps/Visual\ Studio\ Code.app/Contents/MacOS/Electron";
			vi = "nvim";
			curl = "xh";
			htop = "btop";
			compose = "docker-compose";
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
					"git" "gitignore" "docker" "docker-compose" "kube-ps1" "kubectl" "helm" "argocd" "terraform"
					"bun" "colored-man-pages" "copyfile" "copypath" "redis-cli" "rust" "sudo" "tmux"
				];
			};

			initExtra = ''
				PROMPT='$(kube_ps1) '$PROMPT
				precmd() { echo; }

				eval $(thefuck --alias)
			'';
		};
	};
}
