# vim:fdm=marker

# PATH {{{
if [[ $(uname) == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="$HOME/.local/scripts:$PATH"
# PATH }}}

# history {{{
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=40000

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
# PROMPT='%(?.%F{green}󱦰.%F{red}󱦰)%f %F{cyan}%1~%f ' #U+f19b0
PROMPT='%(?.%F{green}😺.%F{red}😾)%f %F{cyan}%1~%f '

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# RPROMPT='${vcs_info_msg_0_}'
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

# tmux {{{
# See https://qiita.com/ssh0/items/a9956a74bff8254a606a
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | fzf | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi
# tmux }}}
