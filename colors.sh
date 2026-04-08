#!/bin/bash

COUNT=0
RESET="\033[0m"
SLEEP="${1:-1}"

read ROWS COLS < <(stty size 2>/dev/null)

[[ -z "$ROWS" || "$ROWS" -le 0 ]]	&& ROWS=24
[[ -z "$COLS" || "$COLS" -le 0 ]]	&& COLS=80
if [[ -n "$1" && "$1" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
	SLEEP="$1"
else
	SLEEP=1
fi

while true; do
	if [ "$COUNT" -eq 100 ]; then
		COUNT=0
		read ROWS COLS < <(stty size 2>/dev/null)
		[[ -z "$ROWS" || "$ROWS" -le 0 ]] && ROWS=24
		[[ -z "$COLS" || "$COLS" -le 0 ]] && COLS=80
	fi

	R=$((RANDOM % ROWS + 1))
	C=$((RANDOM % COLS + 1))
	COLOR="\033[4$((RANDOM % 8))m"

	echo -ne "\033[s"
	echo -ne "\033[${R};${C}H${COLOR} ${RESET}"
	echo -ne "\033[u"

	COUNT=$((COUNT + 1))
	sleep "$SLEEP"
done