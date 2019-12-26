#!/bin/bash
#
# Copyright (C) 2020 Leah Lackner <evyli@mailbox.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
set -euo pipefail
IFS=$'\n\t'

help() {
    cat << EOF
usage: $0 <cmd>

Provide a file 'archlinux.iso' in this directory.

Commands:
    init
    start-iso
    boot

Copyright (C) 2020 Leah Lackner <evyli@mailbox.org>
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions.
EOF
}

cmd-init() {
    cmd-cleanup
    qemu-img create -f qcow2 archlinux.img 40G
}

cmd-cleanup() {
    rm -f archlinux.img
}

cmd-start-iso() {
    if [[ ! -f archlinux.img ]]; then
        echo "First run '$0 init'"
        exit 1
    fi
    if [[ ! -f archlinux.iso ]]; then
        echo "First download an archlinux iso and place the file here: 'archlinux.iso'"
        exit 1
    fi
    qemu-system-x86_64 -m 4G -hda archlinux.img -cdrom archlinux.iso -boot d 
}

cmd-boot() {
    if [[ ! -f archlinux.img ]]; then
        echo "First run '$0 init'"
        exit 1
    fi
    qemu-system-x86_64 -m 4G -hda archlinux.img
}

cmd="${1:-}"
shift 1 || true
case "${cmd:-}" in
    init)                               cmd-init "$@";;
    cleanup)                            cmd-cleanup "$@";;
    start-iso)                          cmd-start-iso "$@";;
    boot)                               cmd-boot "$@";;
    help)                               help "$@";;
    *)                                  help "$@"; exit 1;;
esac

