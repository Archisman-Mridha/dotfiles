{ pkgs, system, ... }:
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
			if system == "aarch64-darwin" then {
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
					"docker" "docker-compose" "kubectl" "helm" "argocd" "terraform"
					"git" "gitignore" "colored-man-pages" "copyfile" "copypath" "redis-cli" "sudo" "tmux"
					"bun" "rust"
				];
			};

			initExtra = ''
				# Gets rid of this error :
				# 	/nix/store/0pn1878v285l3nrfcagbb93bkkkbm811-oh-my-zsh-2024-10-01/share/oh-my-zsh/plugins/kube-ps1/kube-ps1.plugin.zsh:27: character not in range
				#
				# REFER : https://github.com/jonmosco/kube-ps1/issues/80#issuecomment-471517669.
				export LC_ALL="en_US.UTF-8";
				export LANG="en_US.UTF-8";

				plugins+=("kube-ps1")

				PROMPT='$(kube_ps1) '$PROMPT
				precmd() { echo; }

				eval $(thefuck --alias)
			'' + (if system == "x86_64-linux" then "source '/opt/kube-ps1/kube-ps1.sh'" else "");
		};
	};
}
