# PS1='%n@%m %~$ '
PS1='%F{green}%D{%I:%M:%S %p}%f %F{blue}%~%f$ '
PATH="/usr/local/bin:$HOME/.local/bin/:/usr/local/go/bin:$HOME/go/bin:$PATH:$HOME/.cargo/env"

# enable plugins
source ~/.zsh/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

# Znap
# $ znap status // show status of plugins
# $ zanp pull // update all plugins
[[ -r ~/.zsh/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zsh/znap
source ~/.zsh/znap/znap.zsh

# Aliases
alias docker-compose="docker compose"
alias dup="docker compose up -d"
alias ddown="docker compose down"
alias dsh='f() { docker exec -it $1 bash};f'
alias dshr='f() { docker exec -uroot -it $1 bash};f'
alias lg="lazygit"
alias mkcdir='f() { mkdir -- "$1" && cd -- "$1" }; f'
alias nv="nvim"
alias p="cd \$(find ~ -type d -maxdepth 2 | fzf)"
alias cdf="cd \$(find . -type d -maxdepth 4 | fzf)"
alias rms='f() { mv $1 ~/.local/share/Trash/files/ }; f'
alias n="nnn"
alias ll="ls -lah"


alias gblame="tig blame \$(fzf)"
alias xcp="xclip -selection c"

alias zlj="zellij"
zl() {
    # Use fzf to select a session line directly from the output of zellij ls
    local selected_line=$(zellij ls | fzf --height=10 --border --ansi --prompt="Select session> ")
    
    # Extract the session name from the selected line
    local session_name=$(echo "$selected_line" | awk '{print $1}')
    
    # Check if a session name was extracted
    if [[ -n $session_name ]]; then
        # Attach to the selected session
        zellij a "$session_name"
    else
        echo "No session selected."
    fi
}

alias git-personal="git config --local user.name karintomania && \
git config --local user.email 19652340+karintomania@users.noreply.github.com && \
sed -i 's/git@github\.com/git@github.personal/g' .git/config"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias -s sh=zsh

export EDITOR='hx'
export FZF_DEFAULT_COMMAND="find ."
export CLICOLOR=1
export NNN_PLUG="f:fzcd;c:cppath;"
export NNN_OPTS="H"
export AWS_PROFILE=transactions-dev


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/share/../bin/env"
