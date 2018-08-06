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

PATH="$HOME/bin:$HOME/.composer/vendor/bin:$PATH"

source /home/vagrant/git-prompt.sh

if [[ ${EUID} == 0 ]] ; then
    export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\w \[\033[33m\]$(__git_ps1 "%s ")\[\033[01;31m\]\#\[\033[00m\] '
else
    export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\w \[\033[33m\]$(__git_ps1 "%s ")\[\033[01;32m\]🔨 \[\033[00m\] '
fi
