{ pkgs, ... }:
let
  tmux-palette = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-palette";
    version = "unstable-2024-01-01";
    src = pkgs.fetchFromGitHub {
      owner = "eduwass";
      repo = "tmux-palette";
      rev = "main";
      sha256 = "sha256-HrMIADMNolTlBLilS/kPFTXYMCkpsS4CE5agw1jSWFA=";
    };
    nativeBuildInputs = [ pkgs.bun ];

    # home-manager sources plugins via run-shell using underscores in the filename
    # (tmux_palette.tmux), but the plugin ships with a hyphen (tmux-palette.tmux).
    # The symlink bridges that mismatch. bun is also not in tmux's PATH at runtime,
    # so all bun invocations in plugin scripts are rewritten to the absolute Nix store
    # path. node_modules are pre-installed here so the plugin doesn't attempt a
    # writable install from the read-only Nix store at runtime.
    postInstall = ''
      cd $target
      HOME=$TMPDIR bun install
      find $target \( -name "*.tmux" -o -name "*.sh" \) \
        -exec sed -i 's|bun |${pkgs.bun}/bin/bun |g' {} +
      ln -s tmux-palette.tmux $target/tmux_palette.tmux
    '';
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

      bind b set -g status

      # M-f (\033f) is what Ghostty sends for option+right (forward-word). Keep it
      # unbound in tmux so it passes through to the shell for word navigation.
      unbind-key -n M-f
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmux-palette;
        extraConfig = ''
          set -g @palette-key 'off'
          set -g @palette-find-pane-key 'M-t'
          set -g @palette-move-pane-key 'M-m'
        '';
      }
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_window_id_style super
          set -g @tokyo-night-tmux_pane_id_style super
          set -g @tokyo-night-tmux_zoom_id_style super

          set -g @tokyo-night-tmux_show_git 0
          set -g @tokyo-night-tmux_show_datetime 0
          set -g @tokyo-night-tmux_date_format MYD
          set -g @tokyo-night-tmux_time_format 12H

          set -g @tokyo-night-tmux_transparent 1

          set-option -g status-position top
        '';
      }
      sensible
      vim-tmux-navigator
      yank
      tmux-fzf
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
