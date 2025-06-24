#!/bin/bash

# all colors used in the script
_BLACK='\033[0;30m' _RED='\033[0;31m' _GREEN='\033[0;32m' _YELLOW='\033[0;33m'
_BLUE='\033[0;34m' _PURPLE='\033[0;35m' _CYAN='\033[0;36m' _WHITE='\033[0;37m'
_BBLACK='\033[1;30m' _BRED='\033[1;31m' _BGREEN='\033[1;32m' _BYELLOW='\033[1;33m'
_BBLUE='\033[1;34m' _BPURPLE='\033[1;35m' _BCYAN='\033[1;36m' _BWHITE='\033[1;37m'
_RESET='\033[0m'

_ALL_COLORS=(
  $_BLACK $_RED $_GREEN $_YELLOW $_BLUE $_PURPLE $_CYAN $_WHITE
  $_BBLACK $_BRED $_BGREEN $_BYELLOW $_BBLUE $_BPURPLE $_BCYAN $_BWHITE
)

LINES=(
""
""
" ___       ________  ________  ___  __             ___    ___ ________  ___  ___  ________     "
"|\\  \\     |\\   __  \\|\\   ____\\|\\  \\|\\  \\          |\\  \\  /  /|\\   __  \\|\\  \\|\\  \\|\\   __  \\    "
"\\ \\  \\    \\ \\  \\|\\  \\ \\  \\___|\\ \\  \\/  /|_        \\ \\  \\/  / | \\  \\|\\  \\ \\  \\\\\\  \\ \\  \\|\\  \\   "
" \\ \\  \\    \\ \\  \\\\\\  \\ \\  \\    \\ \\   ___  \\        \\ \\    / / \\ \\  \\\\\\  \\ \\  \\\\\\  \\ \\   _  _\\  "
"  \\ \\  \\____\\ \\  \\\\\\  \\ \\  \\____\\ \\  \\\\ \\  \\        \\/  /  /   \\ \\  \\\\\\  \\ \\  \\\\\\  \\ \\  \\\\  \\| "
"   \\ \\_______\\ \\_______\\ \\_______\\ \\__\\\\ \\__\\     __/  / /      \\ \\_______\\ \\_______\\ \\__\\\\ _\\ "
"    \\|_______|\\|_______|\\|_______|\\|__| \\|__|    |\\___/ /        \\|_______|\\|_______|\\|__|\\|__|"
"                                                 \\|___|/                                       "
"                                                                                               "
"                                                                                               "
"                   ________  _______   ________  ___  ________  ________                       "
"                  |\\   ____\\|\\  ___ \\ |\\   ____\\|\\  \\|\\   __  \\|\\   ___  \\                     "
"                  \\ \\  \\___|\\ \\   __/|\\ \\  \\___|\\ \\  \\ \\  \\|\\  \\ \\  \\\\ \\  \\                    "
"                   \\ \\_____  \\ \\  \\_|/_\\ \\_____  \\ \\  \\ \\  \\\\\\  \\ \\  \\\\ \\  \\                   "
"                    \\|____|\\  \\ \\  \\_|\\ \\|____|\\  \\ \\  \\ \\  \\\\\\  \\ \\  \\\\ \\  \\                  "
"                      ____\\_\\  \\ \\_______\\____\\_\\  \\ \\__\\ \\_______\\ \\__\\\\ \\__\\                 "
"                      |\\_________\\|_______|\\_________\\|__|\\|_______|\\|__| \\|__|                "
"                      \\|_________|        \\|_________|                                         "
""
)

clean_call()
{
	local shell_name history_file

	shell_name=$(basename "$SHELL")
	case "$shell_name" in
		bash)
			history_file=~/.bash_history
			sed -i '$d' "$history_file"
			history -r "$history_file"
			;;
		zsh)
			history_file=~/.zsh_history
			sed -i '$d' "$history_file"
			fc -W "$history_file"
			fc -R "$history_file" 2>/dev/null || true
			;;
		*)
			return
			;;
	esac
}

clean_call

cleanup()
{
	echo -e "\033[?25h" "\033[?1049l" "\033[0m"
	exit 0
}

trap cleanup INT TERM EXIT

echo -e "\033[?25l" "\033[?1049h]"
while true; do
	for color in "${_ALL_COLORS[@]}"; do
		clear

		rows=$(tput lines)
		cols=$(tput cols)

		# Vertical padding
		ascii_height=${#LINES[@]}
		vertical_padding=$(( (rows - ascii_height) / 2 ))
		for ((i = 0; i < vertical_padding; i++)); do
			echo
		done

		# display ASCII art centered
		for line in "${LINES[@]}"; do
			line_length=${#line}
			horizontal_padding=$(( (cols - line_length) / 2 ))
			echo -ne "${color}"
			printf "%*s%s%s\n" $horizontal_padding "" "${line}"
			echo -ne "${_RESET}"
		done

		sleep 0.1
	done
done
