#!/usr/bin/bash
#By CLF
#The Shawshank Redemption

if [[ -z $TERMUX_VERSION ]];then
  echo_red "[E]: Use these feats in Termux!"
  pause
  main
fi
termux_feat() {
  clear
	echo_blue "Developing...\n"
  PROMPT="CLFTools - /termux_feat\n"
	PROMPT+="1. Container feats\n"
  PROMPT+="2. Get some infomations of current OS\n"
  PROMPT+="10. Open project main page\n"
	PROMPT+="0. Go back to the last page\n"
	echo_blue "$PROMPT"
	get_input "Input Your choice: " Input
	case $Input in
	1)
    source ${TEMP}/func/termux/container.sh
		container_menu
		;;
  2)
    source ${TEMP}/func/termux/getinfo.sh
    get_info
    termux_feat
    ;;
  10)
    am start --user 0 -a android.intent.action.VIEW -d "https://github.com/CLF233/CLFTools" > /dev/null
    pause
    termux_feat
    ;;
	0)
		main
		;;
	*)
		echo_red "[E]: Bad input: $Input"
    pause
		termux_feat
		;;
	esac
}

# Eh, I have to say that this is a script with full of shitcode ;(
