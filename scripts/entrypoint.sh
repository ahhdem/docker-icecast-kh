#!/bin/bash
TMPDIR=$(mktemp -d)     # Set TMPDIR for entrypoint process
. /util.sh              # Import utility functions

function cleanup() {
  rm -rf  ${TMPDIR}
}

trap cleanup EXIT

/tokenize.sh
supervise icecast icecast -n -c /etc/icecast/icecast.xml&
main_process='icecast'
_pidfile="${TMPDIR}/${main_process}.pid"
while [ ! -e ${_pidfile} ]; do
  echo "Waiting for ${main_process}.."
  sleep 0.1
done
ls -alhrt /tmp/* /etc/icecast
tail --pid $(cat $_pidfile) -f /dev/null
