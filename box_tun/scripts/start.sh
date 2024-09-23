#!/system/bin/sh
clear
scripts=$(realpath $0)
scripts_dir=$(dirname ${scripts})
parent_dir=$(dirname ${scripts_dir})
module_dir="/data/adb/modules/box_tun-module"

source ${scripts_dir}/box_tun.service
if [ ! -f "${module_dir}/disable" ]; then
  log Info "The process is starting, please wait"
else
  log Warn "Please turn on the mask switch"
fi

# environment variables
export PATH="/data/adb/magisk:/data/adb/ksu/bin:$PATH:/system/bin"

# Check if the disable file does not exist, then run the proxy
if [ ! -f "${module_dir}/disable" ]; then
  start_tun # >/dev/null 2>&1
fi

start_box_tun.inotify() {
  PIDs=($(busybox pidof inotifyd))
  for PID in "${PIDs[@]}"; do
    if grep -q "box_tun.inotify" "/proc/$PID/cmdline"; then
      kill -9 "$PID"
    fi
  done
  inotifyd "${scripts_dir}/box_tun.inotify" "${module_dir}" >/dev/null 2>&1 &
}

start_box_tun.inotify
