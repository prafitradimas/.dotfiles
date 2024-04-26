#! /usr/bin/bash

local log_file = '~/install-log.tx'
local pkgmngr = 'apt-get'

install_nala() {
    echo 'Installing nala' >> $log_file
    sudo $pkgmngr install nala -y
    if which nala > /dev/null 2>&1; then
        pkg = 'nala'
        echo 'nala is installed' >> $log_file
    else
        echo 'nala not installed' >> $log_file
    fi
}

install_curl() {
    echo 'Installing curl' >> $log_file
    sudo $pkgmngr install curl -y
    if which curl > /dev/null 2>&1; then
        echo 'curl is installed' >> $log_file
    else
        echo 'curl is not installed' >> $log_file
    fi
}

install_tmux() {
    echo 'Installing tmux' >> $log_file
    sudo $pkgmngr install tmux -y
    if which tmux > /dev/null 2>&1; then
        echo 'tmux is installed' >> $log_file
    else
        echo 'tmux not installed' >> $log_file
    fi
}

