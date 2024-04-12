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
	alias curl="curl --progress-bar -L"
	curl "https://github.com/AtopesSayuri/APatchAutoPatchTool/raw/main/bin/magiskboot" -O ${TEMP}/ap/magiskboot && chmod u+x ${TEMP}/ap/magiskboot
	curl "https://github.com/bmax121/KernelPatch/releases/download/${KPVER}/kpimg-android" -O ${TEMP}/ap/kpimg-android
	curl "https://github.com/bmax121/KernelPatch/releases/download/${KPVER}/kptools-$OS" -O ${TEMP}/ap/kptools-$OS && chmod u+x ${TEMP}/ap/kptools-android
	unalias curl
}
patch() {
	rm -rf ${TEMP}/ap && mkdir -p ${TEMP}/ap
	cd ${TEMP}/ap || exit 1
	get_input "Input KP version: " KPVER
	get_input "Input boot image path: " BOOTPATH
	get_input "Input SuperKey: " SKEY
	get_tools
	cp $(realpath ${BOOTPATH}) ${TEMP}/ap/boot.img
	./magiskboot unpack boot.img
	./kptools-$OS --patch --skey ${SKEY} --kpimg kpimg-android -i kernel -o kernel
	./magiskboot repack boot.img new.img
	echo_green "I: Success. Output: new.img"
}
unpatch() {
	rm -rf ${TEMP}/ap && mkdir -p ${TEMP}/ap
	cd ${TEMP}/ap || exit 1
	get_tools
}
