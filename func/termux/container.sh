#!/usr/bin/env bash
#By CLF
#Three body

container_menu() {
	PROMPT="CLFTools container_menu\n"
	PROMPT+="1. Download rootfs\n"
	PROMPT+="0. Go to last page\n"
	echo -e "${PROMPT}"
	get_input "Input Your choice: " Input
	case $Input in
	1)
		distro_download
		;;
	0)
		termux_feat
		;;
	*)
		echo_red "E: Bad input: $Input"
		container_menu
		;;
	esac
}

distro_download() {
	get_input "Input a distro: " DISTRO
	LXC_MIRROR="https://mirrors.bfsu.edu.cn/lxc-images"
	# Get rootfs download link of Specified $DISTRO and $VERSION
	# $MIRROR, $DISTRO, $VERSION and $CPU_ARCH are defined at main()
	if [[ ${CPU_ARCH} == "" ]]; then
		get_cpu_arch
	fi
	DISTROPATH=$(curl -sL "${LXC_MIRROR}/meta/1.0/index-system" | grep ${DISTRO} | grep ${CPU_ARCH} | grep -v cloud | tail -n 1 | cut -d ";" -f 6)
	ES=$?
	if [[ $ES != 0 ]]; then
		echo_red "E: Get link failed. Make sure you entered true distro name."
		distro_download
	fi
	rm -f rootfs.tar.xz
	wget "${LXC_MIRROR}${DISTROPATH}rootfs.tar.xz"
}
