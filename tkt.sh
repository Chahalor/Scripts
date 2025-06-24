#!/bin/bash

COUNT=0
ROWS=$(tput lines)
COLS=$(tput cols)

while true; do
	if [ "$COUNT" -eq 100 ]; then
		COUNT=0
		ROWS=$(tput lines)
		COLS=$(tput cols)
	fi
    R=$((RANDOM % ROWS + 1))
    C=$((RANDOM % COLS + 1))
    COLOR="\033[4$((RANDOM % 8))m"
    echo -ne "\033[${R};${C}H${COLOR} ${RESET}"
	COUNT=$((COUNT + 1))
    sleep 0.005
done
