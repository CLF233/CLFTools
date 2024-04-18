#!/usr/bin/bash
# By CLF
# Give civilization to the years, not years to civilization.

get_info() {
	OS_NAME="OS name: \t $(cat /etc/os-release | grep PRETTY_NAME | sed 's/PRETTY_NAME=//g' | sed 's/\"//g')"
	OS_MEMTOTAL="$(cat /proc/meminfo | grep MemTotal)"
	OS_MEMAVAILABLE="$(cat /proc/meminfo | grep MemAvailable)"
	blue "$OS_NAME"
  blue "$OS_MEMTOTAL"
  blue "$OS_MEMAVAILABLE"
}
