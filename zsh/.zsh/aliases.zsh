# Navigation

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Directories
DOTFILES_PATH="$DOTFILES"
LIBRARY_PATH="$HOME/Library"
DOWNLOADS_PATH="$HOME/Downloads"
PROJECTS_PATH="$HOME/Developer/Personal"
WORK_PATH="$HOME/Developer/Work"

alias dotfiles="cd $DOTFILES_PATH"
alias dots="cd $DOTFILES_PATH"

alias library="cd $LIBRARY_PATH"

alias downloads="cd $DOWNLOADS_PATH"
alias dls="cd $DOWNLOADS_PATH"

alias projects="cd $PROJECTS_PATH"
alias prjs="cd $PROJECTS_PATH"

alias work="cd $WORK_PATH"
alias wrk="cd $WORK_PATH"

# Git

alias g="git"
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
# alias gl="git log --oneline --decorate --color"
# alias amend="git add . && git commit --amend --no-edit"
# alias commit="git add . && git commit -m"
# alias diff="git diff"
# alias force="git push --force-with-lease"
# alias nuke="git clean -df && git reset --hard"
# alias pop="git stash pop"
# alias prune="git fetch --prune"
alias pull="git pull"
alias push="git push"
# alias resolve="git add . && git commit --no-edit"
# alias stash="git stash -u"
# alias unstage="git restore --staged ."
# alias wip="commit wip"

# Shortcuts

alias c='clear'

## PNPM
alias pb="pnpm build"
alias pd="pnpm dev"
alias pf="pnpm format"
alias pc="pnpm check-types"
alias pl="pnpm lint"

## List all files colorized in long format
alias l="eza --icons -lF"

## List all files colorized in long format, excluding . and ..
alias la="eza --icons -lAF"
