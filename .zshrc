# ── Instant Prompt ────────────────────────────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Zinit Setup ───────────────────────────────────────────────────
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$ZINIT_HOME"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz +X _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ── Plugins & Theme ───────────────────────────────────────────────

# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Plugins
zinit ice wait lucid
zinit for \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab \
  OMZ::plugins/git/git.plugin.zsh

# ── Completion ────────────────────────────────────────────────────
autoload -Uz compinit && compinit
compinit -C

# ── Terminal / Input ──────────────────────────────────────────────
bindkey -v
export KEYTIMEOUT=1

# ── Optional: Byte-compiling ──────────────────────────────────────
if [[ ~/.zshrc -nt ~/.zshrc.zwc ]]; then
  zcompile ~/.zshrc
fi

# ── History ───────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ── Completion styling ─────────────────────────────────────────────
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ── Shell integrations ─────────────────────────────────────────────
eval "$(zoxide init --cmd cd zsh)"

# ── Aliases ───────────────────────────────────────────────────────
alias ll='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias gs='git status'
alias gl='git pull'
alias gp='git push'
alias gcam='git commit -am'
alias rcreload='source ~/.zshrc'
alias zshrc='cursor ~/.zshrc'
alias activate='source .venv/bin/activate'
alias dotp10k='cursor ~/.p10k.zsh'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
