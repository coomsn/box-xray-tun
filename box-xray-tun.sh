#!/system/bin/sh
scripts_dir="/data/adb/box-xray-tun/scripts"
(until [ "$(getprop sys.boot_completed)" -eq 1 ]; do sleep 3; done; "${scripts_dir}/start.sh") &
