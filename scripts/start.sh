#!/bin/sh

function init() {
  /tokenize.sh
  chown -R icecast /var/log/icecast
}

function icecast() {
  pidfile='/tmp/icy.pid'
  while true; do
    icecast -n -c /etc/icecast/icecast.xml&
    cat $! > $pidfile
    tail --pid $(cat $pidfile) -f /dev/null
    echo "$(date) Restarting icecast"
    sleep 2; # prevent fork flood
  done
}

function ezstream() {
  pidfile='/tmp/ez.pid'
  while true; do
    ezstream -c /etc/icecast/ezstream.xml&
    cat $! > $pidfile
    tail --pid $(cat $pidfile) -f /dev/null
    echo "$(date) Restarting ezstream"
    sleep 2; # prevent fork flood
  done
}

while true; do
  tail --pid $(cat /tmp/icy.pid) -f /dev/null
done
