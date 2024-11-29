#!/system/bin/sh
clear
scripts=$(realpath $0)
scripts_dir=$(dirname ${scripts})
module_dir="/data/adb/modules/box-xray-tun"

source ${scripts_dir}/box-xray-tun.service
if [ ! -f "${module_dir}/disable" ]; then
  log Info "The process is starting, please wait"
else
  log Warn "Please turn on the mask switch"
fi

# environment variables
export PATH="/data/adb/ap/bin:/data/adb/ksu/bin:/data/adb/magisk:$PATH"

# Check if the disable file does not exist, then run the proxy
if [ ! -f "${module_dir}/disable" ]; then
  start_tun # >/dev/null 2>&1
fi

start_inotifyd() {
  PIDs=($(busybox pidof inotifyd))
  for PID in "${PIDs[@]}"; do
    if grep -q "box-xray-tun.inotify" "/proc/$PID/cmdline"; then
      kill -9 "$PID"
    fi
  done
  inotifyd "${scripts_dir}/box-xray-tun.inotify" "${module_dir}" >/dev/null 2>&1 &
}

start_inotifyd

# {version:2.1}