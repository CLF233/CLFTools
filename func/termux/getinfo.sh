#!/usr/bin/bash
#By CLF
#Star Wars

get_info() {
  blue "Model: $(getprop ro.product.model)"
  blue "CPU: $(getprop ro.hardware)"
  blue "Android API ver: $(getprop ro.build.version.sdk)"
  blue "Android version: $(getprop ro.build.version.release)"
  blue "USB config: $(getprop sys.usb.config)"
}
