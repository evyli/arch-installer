#!/bin/bash
#
# Copyright (C) 2017  nytthea <nytthea@member.fsf.org>
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

Commands:
    chroot
    disk-partition
    install
    livedisk-init
    livedisk-increase-cowspace-size
    mount
    umount
    help

Copyright (C) 2017  nytthea <nytthea@member.fsf.org>
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions.
EOF
}

cmd="${1:-}"
shift 1 || true
case "${cmd:-}" in
    chroot)                             cmd-chroot "$@";;
    disk-partition)                     cmd-disk-partition "$@";;
    install)                            cmd-install "$@";;
    livedisk-init)                      cmd-livedisk-init "$@";;
    livedisk-increase-cowspace-size)    cmd-livedisk-increase-cowspace-size "$@";;
    mount)                              cmd-mount "$@";;
    umount)                             cmd-umount "$@";;
    help)                               help "$@";;
    *)                                  help "$@"; exit 1;;
esac
