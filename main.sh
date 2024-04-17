#!/usr/bin/bash
#By CLF
#Love and Peace
#shellcheck disable=SC2086

if [[ "$CLFDEBUG" == "1" ]]; then
	set -x
elif [[ "$CLFDEBUG" == "2" ]]; then
	clear() {
		echo_yellow "[W]: Command clear is used but it has been disabled."
	}
elif [[ "$CLFDEBUG" == "3" ]]; then
	set -x
	clear() {
		echo_yellow "[W]: Command clear is used but it has been disabled."
	}
fi
#Colorful echo funcs
echo_yellow() {
	echo -e "\033[33m${1}\033[0m"
}
echo_blue() {
	echo -e "\033[34m${1}\033[0m"
}
echo_green() {
	echo -e "\033[32m${1}\033[0m"
}
echo_red() {
	echo -e "\033[31m${1}\033[0m"
}

# useful funcs
download_and_check() { # download and check. if fail: exit $?
	echo_blue "[I]: Downloading..."
	curl -L "$@"
	ES=$?
	if [[ "${ES}" != "0" ]]; then
		echo_red "[E]: Download failed."
		exit $ES
	else
		echo_green "[I]: Download success."
	fi
}
pause(){
  echo -e "\033[34m"
  read -p "[I]: Press ENTER to continue"
  echo -e "\033[0m"
}
if_empty_red() { # if $1 empty then echo_red
	if [[ "${1}" == "" ]]; then
		echo_red "[E]: Bad empty input."
	fi
}
if_empty_run() { # if $1 is empty then run $2
	if [[ "${1}" == "" ]]; then
		echo_red "[E]: Bad empty input."
		$2
	fi
}
# input func
get_input() {
	read -r -p "$1" "$2"
}

# vars and other preparetion
## get OS
if (command -v getprop >/dev/null 2>&1); then
	OS=android
else
	OS=linux
fi
## set up CODETOEXIT
CODETOEXIT="${RANDOM}"
while [[ $CODETOEXIT -lt 10 ]];do
  CODETOEXIT="${RANDOM}"
done
## set tmp folder
TEMP="${PREFIX}/tmp/CLF${RANDOM}"
rm -rf $PREFIX/tmp/CLF*
mkdir -p ${TEMP}
cp -rf $(realpath $0 | sed 's/\/main.sh//g')/* ${TEMP}

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
	clear
	PROMPT="CLFTools - Ver 0.1.0 - / \n"
	PROMPT+="By CLF\n"
	PROMPT+="1. Termux features\n"
	PROMPT+="2. Linux features\n"
	PROMPT+="3. APatch patch\n"
	PROMPT+="4. Quickly config git\n"
	PROMPT+="0. Exit\n"
	echo_blue "${PROMPT}"
	get_input "Input Your choice: " Input
	case $Input in
	1)
		source ${TEMP}/func/termux/main.sh
		termux_feat
		;;
	2)
		source ${TEMP}/func/linux/main.sh
		linux_feat
		;;
	3)
		source ${TEMP}/func/apatch/main.sh
		apatch_feat
		;;
	4)
		source ${TEMP}/func/ghconfig/main.sh
		gh_config
		;;
	0)
		exit 0
		;;
	*)
		echo_red "[E]: Bad input: $Input"
		pause
		main
		;;
	esac
}

if [[ -n $* ]]; then
	$CUSCMD
fi
main
