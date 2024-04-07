# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load ?
# Standard plugins can be found in $ZSH/plugins/. Custom plugins may be added to $ZSH_CUSTOM/plugins/.
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git argocd bun colored-man-pages copyfile copypath docker docker-compose gitignore helm kubectl
	kube-ps1 redis-cli rust sudo terraform tmux
)

precmd() { echo; }

source $ZSH/oh-my-zsh.sh
PROMPT='$(kube_ps1) '$PROMPT

#-- USER CONFIGURATION --

# Preferred editor for local and remote sessions
export EDITOR="nvim"

alias k="kubectl"
alias z="zoxide"
alias ls="eza"
alias cat="bat"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"

# Pomodoro TUI (Requires https://github.com/caarlos0/timer to be installed).
alias work="timer 120m && terminal-notifier -message 'Pomodoro'\
							-title 'Work Timer is up! Take a Break 😌'"
alias rest="timer 20m && terminal-notifier -message 'Pomodoro'\
							-title 'Break is over! Get back to work 💪'"

export PATH=$PATH:"/Users/archismanmridha/go/bin":"/Users/archismanmridha/.cargo/bin"