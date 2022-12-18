#!/bin/sh
TEXT=xrandr | grep "HDMI-0 connected"
echo "$TEXT"
