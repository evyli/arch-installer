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

INPUT_M4 = $(shell find src/scripts -type f -name '*.sh.in')

.PHONY: all
all: arch-installer.sh
archcmd.sh: $(INPUT_M4) src/main.sh
	m4 -P $^ > $@ || $(RM) $@
	chmod +x $@
