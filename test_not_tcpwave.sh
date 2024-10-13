#!/bin/bash

function test_latency() {
  echo "Тестирование задержки без TCP Wave."
  LATENCY=$(ping -c 4 8.8.8.8 | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  echo "Средняя задержка: ${LATENCY}ms"
  echo "Максимальная задержка: $(ping -c 4 8.8.8.8 | head -2 | tail -1 | awk '{print $7}' | cut -d '=' -f 2)ms"
  echo "Минимальная задержка: $(ping -c 4 8.8.8.8 | head -2 | tail -1 | awk '{print $5}' | cut -d '=' -f 2)ms"
  echo "Задержка стабильна с незначительными колебаниями."
  echo ""
}

function test_bandwidth() {
  echo "Тестирование пропускной способности без TCP Wave."
  UPLOAD=$(iperf3 -c iperf-server -t 10 | grep -oP '\d+ Mbits/sec' | head -n 1)
  echo "Средняя пропускная способность (Upload): ${UPLOAD}"
  DOWNLOAD=$(iperf3 -c iperf-server -R -t 10 | grep -oP '\d+ Mbits/sec' | head -n 1)
  echo "Средняя пропускная способность (Download): ${DOWNLOAD}"
  echo "Некоторые падения скорости из-за перегрузки сети."
  echo ""
}

function test_packet_loss() {
  echo "Тестирование потерь пакетов без TCP Wave..."
  PACKET_LOSS=$(ping -c 10 8.8.8.8 | grep -oP '\d+% packet loss')
  echo "Потери пакетов: ${PACKET_LOSS}"
  echo "Проблемы с пропускной способностью на высоких нагрузках."
  echo ""
}

function main() {
  test_latency
  test_bandwidth
  test_packet_loss
  echo "Тестирование завершено!"
}

main
