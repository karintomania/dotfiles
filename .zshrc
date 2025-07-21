# PS1='%n@%m %~$ '
# PS1='%F{green}%D{%I:%M:%S %p}%f %F{blue}%~%f$ '
PATH="/usr/local/bin:$HOME/.local/bin/:/usr/local/go/bin:$HOME/go/bin:$PATH:$HOME/.cargo/env"
eval "$(starship init zsh)"

bindkey -v
bindkey -M vicmd 'gl' vi-end-of-line
bindkey -M vicmd 'gh' vi-beginning-of-line
bindkey -M viins jj vi-cmd-mode

# enable plugins
source ~/.zsh/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Znap
# $ znap status // show status of plugins
# $ zanp pull // update all plugins
[[ -r ~/.zsh/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zsh/znap
source ~/.zsh/znap/znap.zsh

# Aliases
alias cdf="cd \$(find . -type d -maxdepth 4 | fzf)"
alias ddown="docker compose down"
alias docker-compose="docker compose"
alias dsh='f() { docker exec -it $1 bash};f'
alias dshr='f() { docker exec -uroot -it $1 bash};f'
alias dup="docker compose up -d"
alias gblame="tig blame \$(fzf)"
alias ghpr="gh pr view --web"
alias lg="lazygit"
alias ll="ls -lah"
alias mkcdir='f() { mkdir -- "$1" && cd -- "$1" }; f'
alias nv="nvim"
alias p="cd \$(find ~ -type d -maxdepth 2 | fzf)"
alias rgf='rg --files | rg'
alias rms='f() { mv $1 ~/.local/share/Trash/files/ }; f'
alias what="echo \$(whoami)@\$(hostname)"
alias xcp="xclip -selection c"
alias zlj="zellij"
alias zls="zellij -s $(basename $(pwd))"

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

# Delete a zellij session with fzf
zld() {
    # Use fzf to select a session line directly from the output of zellij ls
    local selected_line=$(zellij ls | fzf --height=10 --border --ansi --prompt="Select session> ")
    
    # Extract the session name from the selected line
    local session_name=$(echo "$selected_line" | awk '{print $1}')
    
    # Check if a session name was extracted
    if [[ -n $session_name ]]; then
        # Attach to the selected session
        zellij d -f "$session_name"
    else
        echo "No session selected."
    fi
}


alias -s sh=zsh

export EDITOR='nvim'
export FZF_DEFAULT_COMMAND="find ."
export CLICOLOR=1

export SAVEHIST=1000
export HISTFILE="$HOME/.zsh_history"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export KEYTIMEOUT=1

# Add to fpath and initialize completions
fpath=(~/.zsh/completions $fpath)

################################
# Machine Specific goes here   #
################################
source ~/.zshrc.local

