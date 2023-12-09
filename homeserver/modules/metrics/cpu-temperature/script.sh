function get_cpu_temperature() {
  cat /sys/class/thermal/thermal_zone0/temp
}

function main() {
  local raw_temp=$(get_cpu_temperature)
  local temp=$(awk "BEGIN { print $raw_temp / 1000 }")

  # export to local collector
  # deploy直後はcollectorへの接続に失敗する場合がある
  # このscriptが失敗するとdeploy-rsがdeployを失敗と判断して、deploy自体が失敗となる
  # そこで、errorを無視することとしている
  # systemd timer側の設定があればそれを使えるかも知れない
  otel export metrics gauge \
    --endpoint http://localhost:4317 \
    --name system.cpu.temperature \
    --description "cpu temperature" \
    --unit Cel \
    --value-as-double ${temp} \
    --attributes "thermalzone:0" \
    --schema-url https://opentelemetry.io/schemas/1.21.0 \
  || echo "Failed to export. (ignoring)"
}

main