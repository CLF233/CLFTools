#!/usr/bin/bash
#By CFL
#The Avengers

apatch_feat() {
	clear
	PROMPT="CLFTools - /apatch_feat \n"
	PROMPT+="1. Patch a boot image\n"
	PROMPT+="2. Unpatch a boot image\n"
	PROMPT+="0. Go back to the last page\n"
	blue "$PROMPT"
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
	*)
		red "[E]: Bad input: ${input}"
		pause
		apatch_feat
		;;
	esac
}
get_tools() {
	download_and_check --progress-bar "https://github.com/AtopesSayuri/APatchAutoPatchTool/raw/main/bin/magiskboot" -o ${TEMP}/ap/magiskboot && chmod u+x ${TEMP}/ap/magiskboot
	download_and_check --progress-bar "https://github.com/bmax121/KernelPatch/releases/download/${KPVER}/kpimg-android" -o ${TEMP}/ap/kpimg-android
	download_and_check --progress-bar "https://github.com/bmax121/KernelPatch/releases/download/${KPVER}/kptools-$OS" -o ${TEMP}/ap/kptools-$OS && chmod u+x ${TEMP}/ap/kptools-$OS
}
patch() {
	rm -rf ${TEMP}/ap && mkdir -p ${TEMP}/ap
	blue "[I]: Enter \"${CODETOEXIT}\" to stop this action."
	get_input "Input KP version: " KPVER
	if [[ "${KPVER}" == "${CODETOEXIT}" ]]; then
		apatch_feat
	elif [[ -z ${KPVER} ]]; then
		red "[E]: No KP version is specified."
		patch
	fi
	get_input "Input boot image FULL path: " BOOTPATH
	if [[ "${BOOTPATH}" == "${CODETOEXIT}" ]]; then
		apatch_feat
	elif [[ ! -f ${BOOTPATH} ]]; then
		red "[E]: Wrong image path: No such file, or specified path is a folder."
		patch
	elif [[ -z ${BOOTPATH} ]]; then
		red "[E]: Empty image path is not allowed."
		patch
	fi
	get_input "Input SuperKey: " SKEY
	if [[ "${SKEY}" == "${CODETOEXIT}" ]]; then
		apatch_feat
	elif [[ -z ${SKEY} ]]; then
		red "[E]: Empty SuperKey is not allowed."
		patch
	fi
	get_tools
	cp "$BOOTPATH" ${TEMP}/ap/boot.img
	cd ${TEMP}/ap || exit 1
	./magiskboot unpack boot.img
	./kptools-$OS --patch --skey ${SKEY} --kpimg kpimg-android --image kernel --out kernel || exit 1
	./magiskboot repack boot.img new-patched.img
	green "[I]: Success. Output: ${TEMP}/ap/new-patched.img"
	exit 0
}
unpatch() {
	rm -rf ${TEMP}/ap && mkdir -p ${TEMP}/ap
	blue "[I]: Enter \"${CODETOEXIT}\" to stop this action."
	get_tools
	cd ${TEMP}/ap || exit 1
	get_input "Input FULL image path: " BOOTPATH
	if [[ ! -f ${BOOTPATH} ]]; then
		red "[E]: Wrong image path: No such file, or specified path is a folder."
		patch
	elif [[ -z ${BOOTPATH} ]]; then
		red "[E]: Empty image path is not allowed."
		patch
	elif [[ "${BOOTPATH}" == "${CODETOEXIT}" ]]; then
		apatch_feat
	fi
	./magiskboot unpack boot.img
	./kptools-$OS --unpatch --image kernel
	./magiskboot repack boot.img new-unpatched.img || exit 1
	green "[I]: Success. Output: ${TEMP}/ap/new-unpatched.img"
	exit 0
}
