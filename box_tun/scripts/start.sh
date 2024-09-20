#!/system/bin/sh
scripts=$(realpath $0)
scripts_dir=$(dirname ${scripts})
parent_dir=$(dirname ${scripts_dir})
module_dir="/data/adb/modules/box_tun-module"

source ${scripts_dir}/box_tun.service

# environment variables
export PATH="/data/adb/magisk:/data/adb/ksu/bin:$PATH:/system/bin"
export TZ='Asia/Shanghai'

# Check if the disable file does not exist, then run the proxy
if [ ! -f "${module_dir}/disable" ]; then
  run_run # >/dev/null 2>&1
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