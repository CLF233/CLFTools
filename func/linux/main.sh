#!/usr/bin/bash
#By CLF
#The Godfather

linux_feat() {
  clear
	PROMPT="CLFTools - /linux_feat\n"
	PROMPT+="1. Get info of current OS\n"
	PROMPT+="0. Go back to the last page\n"
	blue "$PROMPT"
	get_input "Input your choice: " Input
	case $Input in
	0)
		main
		;;
	1)
		source ${TEMP}/func/linux/getinfo.sh
		get_info
    pause
    linux_feat
		;;
  *)
    red "[E]: Bad input: $Input"
    pause
    linux_feat
    ;;
	esac
}
