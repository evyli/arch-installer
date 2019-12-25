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

Preparations:
  1. Increase the cowspace size on the livedisk: 'mount -o size=1G,remount /run/archiso/cowspace'
  2. Install required packages: 'pacman -Sy && pacman -S pacman-contrib git make m4'
  3. Pull the repository: 'git clone https://github.com/evyli/arch-installer.git'
  4. Run 'make' inside the repository

Install:
  1. Modify the provided configuration file
  2. Run the commands:
    1. > 'livedisk-init' (optional)
    2. > 'disk-partition'
    3. > 'mount'
    4. > 'bootstrap'
    5. > 'install'
    6. > 'chroot' (optional: you can inspect the installed system)
    7. > 'umount'
    8. Reboot into the new system

Inspect the system later:
  Run the commands:
    1. > 'livedisk-init' (optional)
    2. > 'mount'
    3. > 'chroot'
    4. > 'umount'

Copyright (C) 2020 Leah Lackner <evyli@mailbox.org>
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
    bootstrap)                          cmd-bootstrap "$@";;
    install)                            cmd-install "$@";;
    livedisk-init)                      cmd-livedisk-init "$@";;
    livedisk-increase-cowspace-size)    cmd-livedisk-increase-cowspace-size "$@";;
    mount)                              cmd-mount "$@";;
    umount)                             cmd-umount "$@";;
    help)                               help "$@";;
    *)                                  help "$@"; exit 1;;
esac
