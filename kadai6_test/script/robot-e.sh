#!/bin/bash
#set -o errexit
#set -o nounset
#set -o xtrace

. $1

main() {
		_init
		local tty=$(tr -d '\n' < ____TTY.txt)

        spawn "/bin/sleep 3 &"
        sleep 0.01
        [[ ! $(bg_job) =~ sleep ]] && _exit 1
        [[ ! $(fg_job) =~ ish ]] && _exit 2

        spawn "fg"
        [[ ! $(fg_job) =~ sleep ]] && _exit 3
        sleep 3
        spawn "/bin/true"
        [[ ! $(fg_job) =~ ish ]] && _exit 4
        _exit 0
}

main "$@"
