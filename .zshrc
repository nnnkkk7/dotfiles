#!/usr/bin/env zsh

### Added by Zinit's installer
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
### End of Zinit's installer chunk

# シンタックスハイライト
zinit light zdharma/fast-syntax-highlighting
# 入力補完
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# Ctrl+r でコマンド履歴を検索
zinit light zdharma/history-search-multi-word
# クローンしたGit作業ディレクトリで、コマンド `git open` を実行するとブラウザでGitHubが開く
zinit light paulirish/git-open


if (which zprof > /dev/null 2>&1) ;then
    zprof
fi


export PATH="$HOME/.goenv/shims:$PATH"

# コマンドをtypoしたときに聞きなおしてくれる
setopt correct
# 直前のコマンドと同じなら、履歴に残さない
setopt hist_ignore_dups
# ターミナル同士で履歴を共有できる。
setopt share_history

# プロンプトのカラーの設定
# カレントディレクトリの表示とgitのブランチ名を表示
fpath=(~/.zsh $fpath)
if [ -f ${HOME}/.zsh/git-completion.zsh ]; then
        zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh
fi
if [ -f ${HOME}/.zsh/git-prompt.sh ]; then
        source ${HOME}/.zsh/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
setopt PROMPT_SUBST ; PS1='
[%F{green}%~%f]%F{blue}$(__git_ps1 "(%s)")%f\$ '

# curlの設定
export PATH="/usr/local/opt/curl/bin:$PATH"