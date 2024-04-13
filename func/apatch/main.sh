#!/usr/bin/bash
#By CFL
#The Avengers

apatch_feat() {
	PROMPT="CLFTools - apatch_feat\n"
	PROMPT+="1. Patch a boot image\n"
	PROMPT+="2. Unpatch a boot image\n"
	PROMPT+="0. Go back to the last page\n"
	echo_blue "$PROMPT"
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
	curl_with_progressbar() {
		curl -L --progress-bar "$@"
	}
	curl_with_progressbar "https://github.com/AtopesSayuri/APatchAutoPatchTool/raw/main/bin/magiskboot" -o ${TEMP}/ap/magiskboot && chmod u+x ${TEMP}/ap/magiskboot
	curl_with_progressbar "https://github.com/bmax121/KernelPatch/releases/download/${KPVER}/kpimg-android" -o ${TEMP}/ap/kpimg-android
	curl_with_progressbar "https://github.com/bmax121/KernelPatch/releases/download/${KPVER}/kptools-$OS" -o ${TEMP}/ap/kptools-$OS && chmod u+x ${TEMP}/ap/kptools-$OS
}
patch() {
	rm -rf ${TEMP}/ap && mkdir -p ${TEMP}/ap
	get_input "Input KP version: " KPVER
	if [[ -z ${KPVER} ]]; then
		echo_red "E: No KP version is specified."
		patch
	fi
	get_input "Input boot image FULL path: " BOOTPATH
	if [[ ! -f ${BOOTPATH} ]]; then
		echo_red "E: Wrong image path: No such file, or specified path is a folder."
		patch
	elif [[ -z ${BOOTPATH} ]]; then
		echo_red "E: Empty image path is not allowed."
		patch
	fi
	get_input "Input SuperKey: " SKEY
	if [[ -z ${SKEY} ]]; then
		echo_red "E: Empty SuperKey is not allowed."
		patch
	fi
	get_tools
	cp "$BOOTPATH" ${TEMP}/ap/boot.img
	cd ${TEMP}/ap || exit 1
	./magiskboot unpack boot.img
	./kptools-$OS --patch --skey ${SKEY} --kpimg kpimg-android --image kernel --out kernel
	./magiskboot repack boot.img new-patched.img
	echo_green "I: Success. Output: ${TEMP}/ap/new-patched.img"
}
unpatch() {
	rm -rf ${TEMP}/ap && mkdir -p ${TEMP}/ap
	get_tools
	cd ${TEMP}/ap || exit 1
	get_input "Input FULL image path: " BOOTPATH
	if [[ ! -f ${BOOTPATH} ]]; then
		echo_red "E: Wrong image path: No such file, or specified path is a folder."
		patch
	elif [[ -z ${BOOTPATH} ]]; then
		echo_red "E: Empty image path is not allowed."
		patch
	fi
	./magiskboot unpack boot.img
	./kptools-$OS --unpatch --image kernel
	./magiskboot repack boot.img new-unpatched.img
	echo_green "I: Success. Output: ${TEMP}/ap/new-unpatched.img"
}
