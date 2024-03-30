# vim:fdm=marker

# PATH {{{
export PATH="$HOME/.local/bin:$PATH"
# PATH }}}

# history {{{
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS 
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
# history }}}

# completion {{{
if type brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit && compinit

# treat `#`, `~`, and `^` as patterns for filename globbing.
setopt EXTENDED_GLOB

# disable case-insensitive globbing
setopt NO_CASE_GLOB
# completion }}}

# prompt {{{
# autoload -U promptinit; promptinit
# prompt pure

PROMPT='%(?.%F{green}➜.%F{red}➜)%f %F{cyan}%1~%f '
# PROMPT='%(?.%F{green}🍜.%F{red}🍝)%f %F{cyan}%1~%f '
#
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT+='${vcs_info_msg_0_}'
zstyle ':vcs_info:git:*' formats '%F{blue}%s:(%F{red}%b%F{blue})%f '
# prompt }}}

# fish-like {{{
if type brew &>/dev/null
then
	source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
fi
# fish-like }}}

# gpg-agent {{{
# See https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gpg-agent/gpg-agent.plugin.zsh
export GPG_TTY=$TTY

# Fix for passphrase prompt on the correct tty
# See https://www.gnupg.org/documentation/manuals/gnupg/Agent-Options.html#option-_002d_002denable_002dssh_002dsupport
function _gpg-agent_update-tty_preexec {
    gpg-connect-agent updatestartuptty /bye &>/dev/null
}
autoload -U add-zsh-hook
add-zsh-hook preexec _gpg-agent_update-tty_preexec

# If enable-ssh-support is set, fix ssh agent integration
if [[ $(gpgconf --list-options gpg-agent 2>/dev/null | awk -F: '$1=="enable-ssh-support" {print $10}') = 1 ]]; then
    unset SSH_AGENT_PID
    if [[ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    fi
fi
# gpg-agent }}}

# conda initialize {{{
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# conda initialize }}}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
