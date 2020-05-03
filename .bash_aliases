# basic commands
alias rm="rm -i"
alias q="exit"

# fun
alias please="sudo"
alias fucking="sudo"
alias meow="echo meow"

# git
alias add="git add"
alias a="git add"
alias aa="git add ."
alias commit="git commit"
alias c="git commit"
alias cm="git commit -m"
alias fix="git commit --amend --no-edit"
alias amend="git commit --amend"
alias ca="git commit --amend"
alias d="git diff"
alias s="git status"
alias status="git status"
alias push="git push"
alias p="git push"
alias pom="git push origin master"
alias pomf="git push origin master -f"
alias pall="git push origin --all --tags"
alias pull="git pull"
alias prebase="git pull --rebase"
alias pr="git pull --rebase"
alias log="git log"
alias l="git log"

# vim
if command -v nvim; then
	alias vi="nvim" # use nvim if present
else
	alias vi="vim" # otherwise use vim
fi
alias vim="vi"
alias e="vi"

# wget
alias wget="wget -c"

# enable aliases in sudo
alias sudo="sudo "
