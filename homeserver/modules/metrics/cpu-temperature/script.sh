function get_cpu_temperature() {
  cat /sys/class/thermal/thermal_zone0/temp
}

function main() {
  local raw_temp=$(get_cpu_temperature)
  local temp=$(awk "BEGIN { print $raw_temp / 1000 }")
  echo "${temp}"
}

main