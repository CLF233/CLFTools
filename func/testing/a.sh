#!/usr/bin/bash
#WARNING:
# TESTING SCRIPT
# Using this means you bear all your losses

# boot path finder
#NOTE:
# ROOT IS NEEDED

# METHOD 1: command getprop
BOOTPATH="$(getprop ro.frp.pst | sed 's/\/frp//g')/" #NOTE: return boot partition's parent path
# METHOD 2: /vendor/build.prop  #NOTE:can be used in custom rec like twrp.
BOOTPATH="$(sed -n 's/.*ro.frp.pst=\(.*\)\/frp.*/\1/p' /vendor/build.prop)"



# boot suffix finder
# METHOD 1: boot cmdline
BOOTSUFFIX="$(cat /proc/cmdline | tr ' ' '\n' | grep androidboot.slot_suffix | sed 's/androidboot.slot_suffix=//g')" #NOTE: return _a|_b in ab device, and empty in non-ab devices
# METHOD 2: command getprop
BOOTSUFFIX="$(getprop ro.boot.slot_suffix)" #NOTE: return _a|_b in ab device, and empty in non-ab devices
# METHOD 3: command bootctl
BOOTSUFFIX="$(bootctl get-suffix $(bootctl get-current-slot))" #NOTE: return _a|_b in ab device, and empty in non-ab devices
