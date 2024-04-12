#!/usr/bin/env bash
#By CLF
#Star Wars

get_info() {
  echo_blue "Model: $(getprop ro.product.model)"
  echo_blue "CPU: $(getprop ro.hardware)"
  echo_blue "Android API ver: $(getprop ro.build.version.sdk)"
  echo_blue "Android version: $(getprop ro.build.version.release)"
  echo_blue "USB config: $(getprop sys.usb.config)"
}
