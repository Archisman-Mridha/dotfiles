{ pkgs, ... }:

let
  tokyo-night-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night-tmux";
		version = "v1.5.5";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "c245a09e06529ce8f8115ec91bd87554dc0618b4";
      sha256 = "sha256-ATaSfJSg/Hhsd4LwoUgHkAApcWZV3O3kLOn61r1Vbag=";
    };
  };
in {
		programs.tmux = {
			enable = true;

			prefix = "C-a";
			keyMode = "vi";

			plugins = with pkgs.tmuxPlugins; [
				tokyo-night-tmux
				sensible
				vim-tmux-navigator # For easy navigation between Tmux and Neovim panes.
				yank
				tmux-fzf
				better-mouse-mode
				cpu
				weather
				net-speed

				# For saving Tmux sessions across system restarts.
				{
					plugin = resurrect;
					extraConfig = "set -g @resurrect-capture-pane-contents 'on'";
				}
				{
					plugin = continuum;
					extraConfig = "set -g @continuum-restore 'on'";
				}
			];

			extraConfig = ''
				set -g mouse on

				set -g @tokyo-night-tmux_window_id_style none
				set -g @tokyo-night-tmux_pane_id_style none
				set -g @tokyo-night-tmux_zoom_id_style sub
			'';
		};
	}
