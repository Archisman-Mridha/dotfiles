{ pkgs, ... }:
let
  tokyo-night-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night-tmux";
    rtpFilePath = "tokyo-night.tmux";
    version = "1.5.3";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "d34f1487b4a644b13d8b2e9a2ee854ae62cc8d0e";
      hash = "sha256-3rMYYzzSS2jaAMLjcQoKreE0oo4VWF9dZgDtABCUOtY=";
    };
  };
  tmux-palette = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-palette";
    rtpFilePath = "tmux-palette.tmux";
    version = "0.3.0";
    src = pkgs.fetchFromGitHub {
      owner = "eduwass";
      repo = "tmux-palette";
      rev = "6c254f5280570034e24630960777a4782c56be0e";
      hash = "sha256-HrMIADMNolTlBLilS/kPFTXYMCkpsS4CE5agw1jSWFA=";
    };
  };
in
{
  programs.tmux = {
    enable = true;

    prefix = "C-a";
    keyMode = "vi";

    extraConfig = ''
      set-option -g mouse on
      set -g default-terminal "tmux-256color"

      set -g allow-passthrough on

      set -g status-style "bg=#000000"

      bind b set -g status
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_window_id_style none
          set -g @tokyo-night-tmux_pane_id_style none
          set -g @tokyo-night-tmux_zoom_id_style sub

          set -g @tokyo-night-tmux_show_datetime 0
          set -g @tokyo-night-tmux_date_format MYD
          set -g @tokyo-night-tmux_time_format 12H

          set-option -g status-position top
        '';
      }
      sensible
      vim-tmux-navigator
      yank
      tmux-fzf
      better-mouse-mode
      weather
      net-speed
      tmux-palette

      # For saving Tmux sessions across system restarts.
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
  };
}
