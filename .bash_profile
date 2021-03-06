# .bash_profile

PATH=$PATH:$HOME

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

if [ -d "$HOME/gulo-utils-main/utilities" ] ; then
    PATH="$HOME/gulo-utils-main/utilities:$PATH"
fi

if [ -d "/usr/local/mysql/bin" ] ; then
    PATH="/usr/local/mysql/bin:$PATH"
fi

if [ -d "/usr/local/rvm/rubies/default/bin" ] ; then
    PATH="/usr/local/rvm/rubies/default/bin:$PATH"
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
LD_LIBRARY_PATH=/usr/local/lib

export PATH LD_LIBRARY_PATH
export SVNROOT="/svn/"
export SVN_EDITOR=vi

unset USERNAME
alias l='ls -l'
alias svnu='rmdstore; rmunderscores; rmphplogs; svn status; svn update'
alias rmunderscores='find ./ -name \._\* | xargs rm -rf'
alias rmdstore='find ./ -name \.DS_Store | xargs rm -rf'
alias rmphplogs='find ./ -name php_errors.log -print0 | xargs -0 rm -rf'
alias laravel-clear='composer.phar dump-autoload; php artisan clear-compiled; php artisan cache:clear; php artisan config:clear; php artisan route:clear; php artisan view:clear;'
alias node-clear='rm -rf node_modules; rm package-lock.json; npm cache clear --force; npm install;'

SSH_ENV=$HOME/.ssh/environment

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    #ps ${SSH_AGENT_PID} doesn’t work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
      start_agent;
    }
else
    start_agent;
fi
