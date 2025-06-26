#!/bin/bash

# text colors
_BLACK='\033[0;30m' _RED='\033[0;31m' _GREEN='\033[0;32m' _YELLOW='\033[0;33m'
_BLUE='\033[0;34m' _PURPLE='\033[0;35m' _CYAN='\033[0;36m' _WHITE='\033[1;37m'
_BBLACK='\033[1;30m' _BRED='\033[1;31m' _BGREEN='\033[1;32m' _BYELLOW='\033[1;33m'
_BBLUE='\033[1;34m' _BPURPLE='\033[1;35m' _BCYAN='\033[1;36m' _BWHITE='\033[1;37m'
_RESET='\033[0m'

# background colors
_BGBLACK='\033[40m' _BGBLUE='\033[44m' _BGCYAN='\033[46m'
_BGPURPLE='\033[45m' _BGBLACK='\033[40m' _BGYELLOW='\033[43m'
_BGBLACK='\033[40m' _BGGREEN='\033[42m' _BGBLACK='\033[40m'

_ALL_COLORS=(
  $_BLACK $_RED $_GREEN $_YELLOW $_BLUE $_PURPLE $_CYAN $_WHITE
  $_BBLACK $_BRED $_BGREEN $_BYELLOW $_BBLUE $_BPURPLE $_BCYAN $_BWHITE
)

LIST_MOUSE=$(xinput list | grep Mouse | awk -F'id=' '{print $2}' | awk '{print $1}')

typewriter()
{
	local text="$1"
	local delay="0.003"  # par défaut : 30ms entre chaque caractère
	for ((i=0; i<${#text}; i++)); do
		printf "%s" "${text:$i:1}"
		sleep "$delay"
	done
	sleep $((RANDOM % 3))
	echo "$2"
}

restart()
{
	local	attemps=0
	local	max_attempts=5
	while true; do
		echo -e "  Initializing session recovery modules..."
		sleep 1

		modules=(
			"Loading module: ShameSuppressor_v1.2.........................."
			"Initializing ProcrastinationDetour™ Engine...................."
			"Calibrating EgoRestorer with sarcasm level: MAX..............."
			"Verifying excuses database (excuses.db)......................."
			"Installing AntiStupidityFirewall (trial version).............."
			"Patching memory leaks in FocusModule.........................."
			"Asking chat-gpt for help......................................"
			"Launching CoffeeInjector......................................"
			"Updating LockSessionReflex™ AI model.........................."
			"Reinitializing MotivationDriver..............................."
			"Attempting recovery from UserFailureException................."
		)

		sleep $(awk -v min=0.5 -v max=1.0 'BEGIN{srand(); printf "%.1f", min+rand()*(max-min)}')
		for module in "${modules[@]}"; do
			
			# 20% chance d’échec
			if (( RANDOM % 5 == 0 && attemps <= max_attempts )); then
				typewriter "    > $module" "[FAIL]"
				sleep 1
				echo -e "        ↳ Reason: ${module//\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\./}"
				sleep 2.5
				continue 2  # redémarre la boucle while depuis le début
			else
				case "$module" in
					*"excuses database"*)
						typewriter "    > $module" "[FOUND: 237 excuses]"
						;;
					*"FocusModule"*)
						typewriter "    > $module" "[CRITICAL PATCH APPLIED]"
						;;
					*"CoffeeInjector"*)
						typewriter "    > $module" "[DOSE: DOUBLE ESPRESSO]"
						;;
					*"LockSessionReflex"*)
						typewriter "    > $module" "[TRAINED ON: Shame Dataset v3]"
						;;
					*"MotivationDriver"*)
						typewriter "    > $module" "[WARNING: Motivation not found]"
						;;
					*"UserFailureException"*)
						typewriter "    > $module" "[RECOVERY POSSIBLE]"
						;;
					*"chat-gpt"*)
						typewriter "    > $module" "[FAILED: What a surprise!]"
						;;
					*)
						typewriter "    > $module" "[OK]"
						;;
				esac
			fi
		done
		break
	done
}


cleanup()
{
	echo -e "\033[?25h" "\033[?1049l" "\033[0m"
	for device in ${LIST_MOUSE}; do
		xinput enable "$device" 2>/dev/null || true
	done
	exit 0
}

init()
{
	trap cleanup INT TERM EXIT

	echo -e "\033[?25l" "\033[?1049h"
	for device in ${LIST_MOUSE}; do
		xinput disable "$device" 2>/dev/null || true
	done
	clear
}

init

echo -e "${_BGBLUE}${_WHITE}"
echo -e "  A fatal error has occurred."
echo -e "  ---------------------------"
echo -e ""
echo -e "  *** STOP: 0x0000DEAD (USER_FORGOT_TO_LOCK_SESSION)"
echo -e ""
echo -e "  The system has been shut down to prevent embarrassment."
echo -e "  If this is the first time you've seen this Stop error screen,"
echo -e "  shame on you. You should always lock your session."
echo -e ""
echo -e "  Press ENTER to feel shame."
echo -e ""
echo -e "  Technical Information:"
echo -e "  *** Session_Lock_Missing ***"
echo -e "  *** Blame Level: 99%"
echo -e ""
echo -e "  If you need to restart your session, press ENTER to process."
read -r
restart
echo -e "  "
echo -e "\n  Session recovery complete. You may now pretend you're responsible."
echo -e "  Press ENTER to resume your ~delusions~ work."
read -r
