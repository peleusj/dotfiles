# -----------------------------------------------------------------------------
# Options
# -----------------------------------------------------------------------------
[ -f ~/.zsh_options ] && source ~/.zsh_options

# -----------------------------------------------------------------------------
# Zinit Installation
# -----------------------------------------------------------------------------
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

# eval "$(starship init zsh)"

setopt PROMPT_SUBST
autoload -U colors && colors

zinit snippet OMZL::git.zsh

# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT="%(?:%{$fg_bold[magenta]%}ζ :%{$fg_bold[red]%}ζ )"
PROMPT+='%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}\u2717"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# -----------------------------------------------------------------------------
# Zinit Plugins
# -----------------------------------------------------------------------------

# https://github.com/zimfw/completion
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.cache/zsh/.zcompcache
zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit -C -d ~/.cache/zsh/.zcompdump

# fzf-tab needs to be loaded after compinit, but before plugins which
# will wrap widgetssuch as zsh-autosuggestions or fast-syntax-highlighting!!
# https://github.com/Aloxaf/fzf-tab/issues/24
# https://github.com/yutkat/dotfiles/blob/main/.config/zsh/rc/completion.zsh
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# https://github.com/skywind3000/z.lua
export _ZL_DATA=$HOME/.cache/zsh/.zlua
zinit ice atload"eval $(lua $HOME/.local/share/zinit/plugins/skywind3000---z.lua/z.lua --init zsh once enhanced fzf)"
zinit light skywind3000/z.lua

zinit wait'1' lucid for \
  OMZP::colored-man-pages \
  OMZP::gpg-agent \
  OMZP::extract

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# -----------------------------------------------------------------------------
# Misc: FZF Aliases
# -----------------------------------------------------------------------------

export FZF_DEFAULT_OPTS="--border --info=inline"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
