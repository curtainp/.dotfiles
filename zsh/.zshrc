ANTIGEN="$HOME/.local/bin/antigen.zsh"

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
    echo "Installing antigen ..."
    [ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
    [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
    # [ ! -f "$HOME/.z" ] && touch "$HOME/.z"
    URL="http://git.io/antigen"
    TMPFILE="/tmp/antigen.zsh"
    if [ -x "$(which curl)" ]; then
        curl -L "$URL" -o "$TMPFILE"
    elif [ -x "$(which wget)" ]; then
        wget "$URL" -O "$TMPFILE"
    else
        echo "ERROR: please install curl or wget before installation !!"
        exit
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading antigen.zsh ($URL) failed !!"
        exit
    fi;
    echo "move $TMPFILE to $ANTIGEN"
    mv "$TMPFILE" "$ANTIGEN"
fi
# use emacs keybinds for zsh
bindkey -e
autoload -U +X compinit && compinit
export ADOTDIR=$HOME/.local/antigen
source "$ANTIGEN"
antigen bundle 'zsh-users/zsh-autosuggestions'
antigen bundle 'zsh-users/zsh-syntax-highlighting'
antigen bundle 'clarketm/zsh-completions'
antigen bundle 'Aloxaf/fzf-tab'
# antigen bundle 'zsh-users/zsh-completions'
antigen apply
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'


# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.local/zsh_history


export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-15.0.2.jdk/Contents/Home/bin"
export MSF_HOME="/opt/metasploit-framework/bin"
export LLVM_HOME="/usr/local/opt/llvm/bin"
export USR_LOCAL_BIN="/usr/local/bin/"
export LOCAL_BIN="$HOME/.local/bin"
export CARGO_BIN="$HOME/.cargo/bin"
export PATH="$MSF_HOME:$LLVM_HOME:$CARGO_BIN:$JAVA_HOME:$USR_LOCAL_BIN:$LOCAL_BIN:$PATH"


# alias
alias vim='nvim'
alias k='kubectl'
alias cd='z'
(( $+commands[btm] )) && alias top='btm -b'
(( $+commands[exa] )) && alias ls='exa' && alias ll='exa -l' && alias lt='exa --tree'
(( $+commands[kitty] )) && alias diff='kitty +kitten diff'
# config for proxy
#alias proxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
#alias unproxy='unset all_proxy'
alias pc='proxychains4 -q'
alias getip='curl cip.cc'
alias lg='lazygit'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
# export FZF_DEFAULT_OPTS='--height 90% --layout reverse --border --color "border:#b877db" --preview="bat --color=always {}"'
export FZF_DEFAULT_OPTS="--height=10 --reverse --cycle"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER='\'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
