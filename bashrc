# lots of stuff taken from https://github.com/Z1MM32M4N/dotfiles/blob/master/bash_profile

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export EDITOR='vim'
export BIBFILE="/Users/rayli/Dropbox/Latex/rayyli.bib"

###### SAMPLE USE OF bib commands ######
## Rays-Air:www rayli$ bibfind GuruswamiS99
## 1999
## http://dblp.dagstuhl.de/search/publ/api?q=Guruswami%201999&format=json
##   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
##                                  Dload  Upload   Total   Spent    Left  Speed
## 100  3738    0  3738    0     0   6603      0 --:--:-- --:--:-- --:--:--  6604
## "info":{"authors":{"author":["Venkatesan Guruswami","Madhu Sudan"]},"title":"Improved decoding of Reed-Solomon and algebraic-geometry codes.","venue":"IEEE Trans. Information Theory","volume":"45","number":"6","pages":"1757-1767","year":"1999","type":"Journal Articles","key":"journals/tit/GuruswamiS99","doi":"10.1109/18.782097","ee":"https://doi.org/10.1109/18.782097","url":"http://dblp.org/rec/journals/tit/GuruswamiS99"},
## "info":{"authors":{"author":["Venkatesan Guruswami","Amit Sahai"]},"title":"Multiclass Learning, Boosting, and Error-Correcting Codes.","venue":"COLT","pages":"145-155","year":"1999","type":"Conference and Workshop Papers","key":"conf/colt/GuruswamiS99","doi":"10.1145/307400.307429","ee":"http://doi.acm.org/10.1145/307400.307429","url":"http://dblp.org/rec/conf/colt/GuruswamiS99"},
## Rays-Air:www rayli$ bibadd http://dblp.org/rec/journals/tit/GuruswamiS99
## http://dblp.org/rec/bib2/journals/tit/GuruswamiS99
##   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
##                                  Dload  Upload   Total   Spent    Left  Speed
## 100   602    0   602    0     0   1420      0 --:--:-- --:--:-- --:--:--  1423
## @article{GuruswamiS99,
##   author    = {Venkatesan Guruswami and
##                Madhu Sudan},
##   title     = {Improved decoding of Reed-Solomon and algebraic-geometry codes},
##   journal   = {{IEEE} Trans. Information Theory},
##   volume    = {45},
##   number    = {6},
##   pages     = {1757--1767},
##   year      = {1999},
##   url       = {https://doi.org/10.1109/18.782097},
##   doi       = {10.1109/18.782097},
##   timestamp = {Sun, 28 May 2017 13:18:46 +0200},
##   biburl    = {http://dblp.org/rec/bib/journals/tit/GuruswamiS99},
##   bibsource = {dblp computer science bibliography, http://dblp.org}
## }
###### END SAMPLE USE OF bib commands ######

function bibcd () {
  cd "/Users/rayli/Dropbox/Latex/"
}

function bibdiff () {
  (cd "/Users/rayli/Dropbox/Latex/"; git diff rayyli.bib)
}

function bibcommit () {
  date=$(date +%F_%T)
  (cd "/Users/rayli/Dropbox/Latex/"; git add rayyli.bib; git commit -m "Autoupdate rayyli.bib with new entries")
}

function bibclean () {
  cd "/Users/rayli/Dropbox/Latex/"
  bib="rayyli.bib"
  date=$(date +%F_%T)
  cp $bib bib_back/$bib.$date
  bibtool --preserve.key.case=on --check.double.delete=on -s -d -i $bib -o $bib
}

function bibfileadd () {
  date=$(date +%F_%T)
  dir="/Users/rayli/Dropbox/Latex/"
  bib_name="rayyli.bib"
  bib=$dir/$bib_name
  bib_back=$dir/bib_back/$bib_name.$date
  cp $bib $bib_back
  bibtool --preserve.key.case=on --check.double.delete=on -s -d -i $1 $bib -o $bib
}

# add file by URL
function bibadd () {
  tmpfile="tmp_AASDFASDF.bib"
  if [ "$#" -eq 1 ]; then
    url=$(echo $1 | sed "s/\/rec\//\/rec\/bib2\//")
    echo $url
    curl $url | sed "/\@proceedings/,/^}$/d" | sed "s/DBLP\(.*\)\///" > $tmpfile
    cat $tmpfile
    bibfileadd $tmpfile
    rm -f $tmpfile
  else
    vi -c ":set paste" $tmpfile
    if [ -s $tmpfile ]; then
      bibfileadd $tmpfile
    fi
    rm -f $tmpfile
  fi
}

# find bib entries on DBLP by key
function bibfind () {
  if [[ "$1" != "${1/ /}" ]]; then
    q=$(echo $1 | sed "s/ /\%20/g")
    url="https://dblp.dagstuhl.de/search/publ/api?q=$q&format=json"
    curl $url
  else
    name=$(echo $1 | sed 's/\([A-Z0-9]\)/ \1/g' | awk '{print $1;}')
    year=$(echo $1 | grep -oE '[0-9]+')
    if [ $((10#$year)) -le 30 ]; then
      year=20"$year";
    else
      year=19"$year";
    fi
    echo $year
    q="$name%20$year"
    url="http://dblp.dagstuhl.de/search/publ/api?q=$q&format=json"
    echo $url
    curl $url | grep $1
  fi
}

#https://github.com/venthur/gscholar
function bibscholar () {
  gscholar "$1"
}

#
#function bibdirectfind () {
#  # author is $1, search is $2
#  initial=$(echo ${1:0:1}  | tr '[:upper:]' '[:lower:]')
#  echo $initial
#  curl http://dblp.dagstuhl.de/pers/tb2/$initial/$1.bib | sed -n -e "/$2/,/^}$/ p"  | sed "s/DBLP.*$2/$2/"
#}
#
#function bibauthorfind () {
#  curl "http://dblp.org/search/author/api?q=$1&format=json"
#}

function lpdf_ref () {
  x=${1%%.*}
	if latex $x.tex; then 
		bibtex $x;
		latex $x.tex;
		pdflatex $x.tex;
		open $x.pdf;
	fi
}

function lpdf_pic_ref () {
  x=${1%%.*}
	if pdflatex $x.tex; then 
		bibtex $x;
		pdflatex $x.tex;
		pdflatex $x.tex;
		open $x.pdf;
	fi
}

function lpdf () {
  x=${1%%.*}
  #if latexmk $x.tex -pdf; then
  if pdflatex $x.tex; then
    open $x.pdf;
  fi
}

function lpdf_nosoln() {
  x=${1%%.*}
  if pdflatex "\def\showsoln{0} \input{$x.tex}"; then
    open $x.pdf;
  fi
}
function lpdf_soln() {
  x=${1%%.*}
  x_soln=$x"_SOLUTIONS"
  if pdflatex "\def\showsoln{1} \input{$x.tex}"; then
    mv -f $x.pdf $x_soln.pdf
    open $x_soln.pdf;
  fi
}

function lpdf_all() {
  lpdf_soln $1;
  lpdf_nosoln $1;
}

function lxe () {
  x=${1%%.*}
  if xelatex $x.tex; then
    open $x.pdf;
  fi
}

function lcont () {
  x=${1%%.*}
  #latexmk -pdf -pvc $x.tex &
  open -a "Skim" $x.pdf;
  latexmk -pvc -pdf -interaction=nonstopmode $x.tex
  #latexmk -pvc -pdf $x.tex
}

function c () {
  DIR=$(dirname $1)
  NAME=$(basename $1)
  comp=$(ls $DIR |grep "^$NAME.*/$")
  wc=$(echo $comp | wc -w)
  first=$(echo $comp | cut -d " " -f 1)
  if [ $wc == 1 ]; then
    cd $DIR/$first
    pwd
    ls
  else
    echo $comp
  fi
}

function backup () {
  cp $1 ~/Dropbox/backup
}

function cd {
	builtin cd "$@" && ls -F
}

alias ..='\cd ..'
alias ...='\cd ../..'
alias ....='\cd ../../..'
alias .....='\cd ../../../..'
alias ......='\cd ../../../../..'

alias rm='rm -i'
alias cp='cp -iv'
alias mv='mv -iv'
alias l='ls -la'
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
alias gt="git status"
alias gp='git push'

# pretty Git log
alias gl='git log --graph --pretty="%C(bold green)%h%Creset%C(auto)%d%Creset %s"'

# pretty Git log, all references
alias gll='gl --all'

# pretty Git log, show authors
alias gla='git log --graph --pretty="%C(bold green)%h%Creset %C(yellow)%an%Creset%C(auto)%d%Creset %s"'

# pretty Git log, all references, show authors
alias glla='gla --all'
