#!/usr/bin/bash
#By CLF
#Love and Peace

#Colorful echo funcs
echo_yellow() {
	echo -e "\033[33m${1}\033[0m"
}
echo_blue() {
	echo -e "\033[34m${1}\033[0m"
}
echo_red() {
	echo -e "\033[31m${1}\033[0m"
}

# TEMP folder
TMP="/tmp/CLF${RAMDOM}"
mkdir -p ${TMP}

# Arg solver #TODO

main() {
	PROMPT="CLFTools - Ver 0.0.1\n"
	PROMPT+="By CLF\n"
	PROMPT+="1. Termux features\n"
	PROMPT+="2. Linux fetures\n"
	PROMPT+="0. Exit\n"
	echo -e "${PROMPT}"
	read -p "Input your choice(INT): " i
	case ${i} in
	1)
		source ${TEMP}/func/termux.sh
		termux_feat
		;;
	2)
		source func/linux.sh
		linux_feat
		;;
	0) exit 0 ;;
	*) echo_red "E: Incorrect input: ${i}\n" ;;
	esac
}

main
