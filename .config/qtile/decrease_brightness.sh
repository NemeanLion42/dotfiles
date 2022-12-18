#!/bin/sh
echo $(($(bat /sys/class/backlight/intel_backlight/brightness) - 1000)) > /sys/class/backlight/intel_backlight/brightness
