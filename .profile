# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# add cargo
PATH="$HOME/.cargo/bin:$PATH"

# add cross compiled gcc and binutils
PATH="/usr/local/i386elfgcc/bin:$PATH"

# git function from https://coderwall.com/p/fasnya/add-git-branch-name-to-bash-prompt
parse_git_branch()
{
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ git:(\1)/'
}

# set PS1
PS1="\[\033[0;32m\]→ \[\033[0;36m\]\w\[\033[0;31m\]\$(parse_git_branch) \[\033[1;34m\]\$ \[\033[0;0m\]"

# add Rust
export PATH="$HOME/.cargo/bin:$PATH"
