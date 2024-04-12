#!/usr/bin/env bash
#By CLF
#The Shawshank Redemption

termux_feat() {
	echo_blue "Developing...\n"
  PROMPT="CLFTools - termux_feat\n"
	PROMPT+="1. Container feats\n"
	PROMPT+="0. Go to last page\n"
	echo -e $PROMPT
	get_input "Input Your choice: " Input
	case $Input in
	1)
    source ${TEMP}/func/termux/container.sh
		container_menu
		;;
	0)
		main
		;;
	*)
		echo_red "E: Bad input: $Input"
		termux_feat
		;;
	esac
}

# Eh, I have to say that this is a script with full of shit ;(
