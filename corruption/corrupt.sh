#!/bin/bash

# Définir les couleurs avec tput
tput civis # Cacher le curseur
clear

# Couleurs (vert et noir façon Matrix)
GREEN=$(tput setaf 2)
BLACK=$(tput setaf 0)
RESET=$(tput sgr0)

# Dimensions du terminal
cols=$(tput cols)
lines=$(tput lines)

# Matrice pour suivre les cases déjà coloriées
declare -A drawn

# Fonction pour dessiner une case
draw_cell() {
	local row=$1
	local col=$2
	tput cup "$row" "$col"
	if (( RANDOM % 3 == 0 )); then
		printf "${BLACK}█${RESET}"
	else
		printf "${GREEN}█${RESET}"
	fi
	drawn["$row,$col"]=1
}

# Calcul des limites de la spirale
top=0
bottom=$((lines - 1))
left=0
right=$((cols - 1))

while (( top <= bottom && left <= right )); do
	# Haut gauche → haut droite
	for (( i=left; i<=right; i++ )); do
		draw_cell $top $i
	done
	((top++))

	# Haut droite → bas droite
	for (( i=top; i<=bottom; i++ )); do
		draw_cell $i $right
	done
	((right--))

	# Bas droite → bas gauche
	for (( i=right; i>=left; i-- )); do
		draw_cell $bottom $i
	done
	((bottom--))

	# Bas gauche → haut gauche
	for (( i=bottom; i>=top; i-- )); do
		draw_cell $i $left
	done
	((left++))

	sleep 0.02 # pour l'effet progressif
done

tput cnorm # Rendre le curseur
tput sgr0
