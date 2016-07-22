# lots of stuff taken from https://github.com/Z1MM32M4N/dotfiles/blob/master/bash_profile

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR='vim'

function lpdf_ref () {
	if latex $1.tex; then 
		bibtex $1;
		latex $1.tex;
		pdflatex $1.tex;
		open $1.pdf;
	fi
}

function lpdf_pic_ref () {
	if pdflatex $1.tex; then 
		bibtex $1;
		pdflatex $1.tex;
		pdflatex $1.tex;
		open $1.pdf;
	fi
}

function lpdf () {
  if pdflatex $1.tex; then
    open $1.pdf;
  fi
}

alias c='cd'
alias rm='rm -i'
alias cp='cp -iv'
alias mv='mv -iv'
alias sl='ls'

alias grep="grep --color=auto"
alias ls="ls -pG"
alias duls="du -h -d1 | sort -hr"
alias cdd="cd .."
alias resolve='cd "`pwd -P`"'
alias reload="source ~/.bash_profile"
alias pyserv="python -m SimpleHTTPServer"
alias py3serv="python3 -m http.server"
alias ip="curl curlmyip.com"
alias purgeswp='rm -i `find . | grep .swp$`'
alias gti="git"

# Git aliases
alias git-lastmerge="git whatchanged -2 --oneline -p"
alias git-last="git whatchanged -1 --oneline -p"

alias ga="git add"
alias gap="git add --patch"

alias gc="git commit"
alias gca="git commit -a"
alias gcm="git commit -m"
alias gcam="git commit -am"

alias gb="git branch"
alias gd="git diff"
alias gs="git status"
alias gp='git push'

# pretty Git log
alias gl='git log --graph --pretty="%C(bold green)%h%Creset%C(auto)%d%Creset %s"'

# pretty Git log, all references
alias gll='gl --all'

# pretty Git log, show authors
alias gla='git log --graph --pretty="%C(bold green)%h%Creset %C(yellow)%an%Creset%C(auto)%d%Creset %s"'

# pretty Git log, all references, show authors
alias glla='gla --all'
