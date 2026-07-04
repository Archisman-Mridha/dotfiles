{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    prefix = "C-a";
    keyMode = "vi";

    extraConfig = ''
      set-option -g mouse on
      set -g default-terminal "tmux-256color"

      set -g allow-passthrough on

      set-option -g status-position top

      bind b set -g status
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      better-mouse-mode

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
