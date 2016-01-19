#!/bin/bash

set -x
set -e

RELEASES_DIR=`dirname "$(readlink -f "$0")"`/../releases
VERSIONS_DIR=$RELEASES_DIR/versions

MIRROR_URL=http://www.us.apache.org/dist/zookeeper

ZOOKEEPER_VERSIONS=(
    "3.3.6"
    "3.4.6"
    "3.5.0-alpha"
    "3.5.1-alpha"
)

ZOOKEEPER_DEFAULT_VERSION=3.5.1-alpha

for i in "${ZOOKEEPER_VERSIONS[@]}"
do
    if [[ $i == $ZOOKEEPER_VERSION ]]; then
        MATCHES=$ZOOKEEPER_VERSION
    fi
done

if [[ -z $MATCHES ]] || [[ -z $ZOOKEEPER_VERSION ]]; then
    ZOOKEEPER_VERSION=$ZOOKEEPER_DEFAULT_VERSION
fi

if [[ ! -d $VERSIONS_DIR ]]; then
    mkdir -p $VERSIONS_DIR
fi

if [[ -d $VERSIONS_DIR/zookeeper-$ZOOKEEPER_VERSION ]]; then
    rm -rf $VERSIONS_DIR/zookeeper-$ZOOKEEPER_VERSION
fi

curl -sSL $MIRROR_URL/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz | tar -xzf - -C $VERSIONS_DIR

if [[ -f $RELEASES_DIR/current ]] || [[ -d $RELEASES_DIR/current ]] || [[ -L $RELEASES_DIR/current ]]; then
    rm -rf $RELEASES_DIR/current
fi

ln -s $VERSIONS_DIR/zookeeper-$ZOOKEEPER_VERSION $RELEASES_DIR/current

