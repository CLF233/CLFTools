#!/usr/bin/env bash
#By CFL
#The Avengers

apatch_feat() {
	PROMPT="CLFTools - apatch_feat\n"
	PROMPT+="1. Patch a boot image\n"
	PROMPT+="2. Unpatch a boot image\n"
	PROMPT+="0. Go back to the last page\n"
  echo -e "$PROMPT"
	get_input "Input your choice: " input
	case $input in
	1)
		patch
		;;
	2)
		unpatch
		;;
	0)
		main
		;;
	esac
}
get_tools() {
  curl_with_progressbar(){
    curl -L --progress-bar "$@"
  }
	curl_with_progressbar "https://github.com/AtopesSayuri/APatchAutoPatchTool/raw/main/bin/magiskboot" -o ${TEMP}/ap/magiskboot && chmod u+x ${TEMP}/ap/magiskboot
	curl_with_progressbar "https://github.com/bmax121/KernelPatch/releases/download/${KPVER}/kpimg-android" -o ${TEMP}/ap/kpimg-android
	curl_with_progressbar "https://github.com/bmax121/KernelPatch/releases/download/${KPVER}/kptools-$OS" -o ${TEMP}/ap/kptools-$OS && chmod u+x ${TEMP}/ap/kptools-$OS
}
patch() {
	rm -rf ${TEMP}/ap && mkdir -p ${TEMP}/ap
	get_input "Input KP version: " KPVER
	get_input "Input boot image path: " BOOTPATH
	get_input "Input SuperKey: " SKEY
	get_tools
  cp $(echo $BOOTPATH) ${TEMP}/ap/boot.img
  cd ${TEMP}/ap || exit 1
	./magiskboot unpack boot.img
	./kptools-$OS --patch --skey ${SKEY} --kpimg kpimg-android -i kernel -o kernel
	./magiskboot repack boot.img new.img
	echo_green "I: Success. Output: new.img"
}
unpatch() {
	rm -rf ${TEMP}/ap && mkdir -p ${TEMP}/ap
	get_tools
  cd ${TEMP}/ap || exit 1
}
