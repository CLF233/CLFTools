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

# input func
Input=""
get_input(){
  read -p "$1" $2
}

# TEMP folder
TMP="/tmp/CLF${RAMDOM}"
mkdir -p ${TMP}

# Arch getter
# It will create a global variable CPU_ARCH
# From tmoe
if [[ $(command -v dpkg) && $(command -v apt-get) ]]; then
	DPKG_ARCH=$(dpkg --print-architecture)
	case ${DPKG_ARCH} in
	armel) ARCH_TYPE="armel" ;;
	armv7* | armv8l | armhf | arm) ARCH_TYPE="armhf" ;;
	aarch64 | arm64* | armv8* | arm*) ARCH_TYPE="arm64" ;;
	i*86 | x86) ARCH_TYPE="i386" ;;
	x86_64 | amd64) ARCH_TYPE="amd64" ;;
	*) ARCH_TYPE=${DPKG_ARCH} ;;
	esac
else
	UNAME_ARCH=$(uname -m)
	case ${UNAME_ARCH} in
	armv7* | armv8l) ARCH_TYPE="armhf" ;;
	armv[1-6]*) ARCH_TYPE="armel" ;;
	aarch64 | armv8* | arm64 | arm*) ARCH_TYPE="arm64" ;;
	x86_64 | amd64) ARCH_TYPE="amd64" ;;
	i*86 | x86) ARCH_TYPE="i386" ;;
	s390*) ARCH_TYPE="s390x" ;;
	ppc*) ARCH_TYPE="ppc64el" ;;
	mips64) ARCH_TYPE="mips64el" ;;
	mips*) ARCH_TYPE="mipsel" ;;
	risc*) ARCH_TYPE="riscv64" ;;
	*) ARCH_TYPE=${UNAME_ARCH} ;;
	esac
fi
export CPU_ARCH=${ARCH_TYPE}

# Arg solver #TODO

main() {
	PROMPT="CLFTools - Ver 0.0.1\n"
	PROMPT+="By CLF\n"
	PROMPT+="1. Termux features\n"
	PROMPT+="2. Linux fetures\n"
	PROMPT+="0. Exit\n"
	echo -e "${PROMPT}"
  get_input "Input Your choice: " "Input"
	case $Input in
	1)
		source ${TEMP}/func/termux.sh
		termux_feat
		;;
	2)
		source func/linux.sh
		linux_feat
		;;
	0)
		exit 0
		;;
	*)
		echo_red "E: Bad input: $Input\n"
		main
		;;
	esac
}

main
