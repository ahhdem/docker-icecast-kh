#!/bin/bash

function init() {
  /tokenize.sh
  chown -R icecast /var/log/icecast
}

TMPDIR=$(mktemp -d)

function run_icecast() {
  pidfile="/${TMPDIR}/icy.pid"
  while true; do
    icecast -n -c /etc/icecast/icecast.xml&
    echo $! > $pidfile
    tail --pid $(cat $pidfile) -f /dev/null
    echo "$(date) Restarting icecast"
    sleep 2; # prevent fork flood
  done
}

function run_ezstream() {
  pidfile="/${TMPDIR}/ez.pid"
  while true; do
    ezstream -c /etc/icecast/ezstream.xml&
    echo $! > $pidfile
    tail --pid $(cat $pidfile) -f /dev/null
    echo "$(date) Restarting ezstream"
    sleep 2; # prevent fork flood
  done
}

while true; do
  run_icecast
  run_ezstream
  tail --pid $(cat /tmp/icy.pid) -f /dev/null
done
