#! /usr/bin/bash

local log = "~/install-log.txt"

print_log() {
    if find ~ -name 'install-log.txt' > /dev/null 2&>; then
        echo "!============ SUMMARY ============!"
        cat $log
        rm $log
        return
    fi
}

which_distro() {
    if [ -f /etc/debian_version ]; then
        echo debian
        return
    elif [ -f /etc/arc-release ]; then
        echo arch
        return
    fi
}
