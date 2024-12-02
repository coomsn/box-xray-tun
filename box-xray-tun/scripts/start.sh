#!/system/bin/sh
clear
scripts=$(realpath $0)
scripts_dir=$(dirname ${scripts})
module_dir="/data/adb/modules/box-xray-tun"
# Environment variable settings
export PATH="/data/adb/ap/bin:/data/adb/ksu/bin:/data/adb/magisk:$PATH"
source ${scripts_dir}/box-xray-tun.service
proxy_service() {
if [ ! -f "${module_dir}/disable" ]; then
  log Info "Module Enabled"
  log Info "start_tun"
  ${scripts_dir}/box-xray-tun.service enable >/dev/null 2>&1
else
  log Warn "Module Disabled"
  log Warn "stop_tun"
  ${scripts_dir}/box-xray-tun.service disable >/dev/null 2>&1
fi
}

start_inotifyd() {
  PIDs=($(busybox pidof inotifyd))
  for PID in "${PIDs[@]}"; do
    if grep -q "${scripts_dir}/box-xray-tun.inotify" "/proc/$PID/cmdline"; then
      kill -9 "$PID"
    fi
  done
  inotifyd "${scripts_dir}/box-xray-tun.inotify" "${module_dir}" >/dev/null 2>&1 &
}

proxy_service
start_inotifyd

# {version2.2}
