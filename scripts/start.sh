#!/bin/sh
env
set -x

/tokenize.sh
chown -R icecast /var/log/icecast
supervisord -c /etc/supervisord.conf
