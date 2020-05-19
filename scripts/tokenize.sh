#!/bin/bash

ICECAST_HOST=${ICECAST_HOST:-icecast}
ICECAST_PASSWORD=${ICECAST_PASSWORD:-mopidy}
ICECAST_EZSTREAM_MOUNT=${ICECAST_EZSTREAM_MOUNT:-fallback}
ICECAST_STREAM_URL=${ICECAST_STREAM_URL:-'http://icecast'}
ICECAST_STREAM_NAME=${ICECAST_STREAM_NAME:-'amazing radio'}


if [ -n "$ICECAST_SOURCE_PASSWORD" ]; then
    sed -i'' -e "s/<source-password>[^<]*<\/source-password>/<source-password>$ICECAST_SOURCE_PASSWORD<\/source-password>/g" /etc/icecast/icecast.xml
fi

if [ -n "$ICECAST_RELAY_PASSWORD" ]; then
    sed -i'' -e "s/<relay-password>[^<]*<\/relay-password>/<relay-password>$ICECAST_RELAY_PASSWORD<\/relay-password>/g" /etc/icecast/icecast.xml
fi

if [ -n "$ICECAST_ADMIN_PASSWORD" ]; then
    sed -i'' -e "s/<admin-password>[^<]*<\/admin-password>/<admin-password>$ICECAST_ADMIN_PASSWORD<\/admin-password>/g" /etc/icecast/icecast.xml
fi

if [ -n "$ICECAST_PASSWORD" ]; then
    sed -i'' -e "s/<password>[^<]*<\/password>/<password>$ICECAST_PASSWORD<\/password>/g" /etc/icecast/icecast.xml
fi

if [ -n "$ICECAST_LOCATION" ]; then
    sed -i'' -e "s/<location>[^<]*<\/location>/<location>$ICECAST_LOCATION<\/location>/g" /etc/icecast/icecast.xml
fi

if [ -n "$ICECAST_HOSTNAME" ]; then
    sed -i'' -e "s/<hostname>[^<]*<\/hostname>/<hostname>$ICECAST_HOSTNAME<\/hostname>/g" /etc/icecast/icecast.xml
fi

if [ -n "$ICECAST_ADMIN" ]; then
    sed -i'' -e "s/<admin>[^<]*<\/admin>/<admin>$ICECAST_ADMIN<\/admin>/g" /etc/icecast/icecast.xml
fi

if [ -n "$ICECAST_MAX_SOURCES" ]; then
    sed -i'' -e "s/<sources>[^<]*<\/sources>/<sources>$ICECAST_MAX_SOURCES<\/sources>/g" /etc/icecast/icecast.xml
fi

if [ -n "$ICECAST_MAX_LISTENERS" ]; then
    sed -i'' -e "s/<clients>[^<]*<\/clients>/<clients>$ICECAST_MAX_LISTENERS<\/clients>/g" /etc/icecast/icecast.xml
fi
