#!/bin/sh
set -e

apk update
apk upgrade

# Install grafana
apk add go git gcc musl-dev nodejs make g++
export GOPATH=/tmp/go
set +e
go get github.com/grafana/grafana
set -e
cd /tmp/go/src/github.com/grafana/grafana
git checkout v$GRAFANA_VERSION
go run build.go setup
/tmp/go/bin/godep restore
go run build.go build
npm i
npm i -g grunt-cli
grunt
mkdir /usr/lib/grafana
cp -R ./conf /usr/lib/grafana/
cp -R ./bin /usr/lib/grafana/
cp -R ./public_gen /usr/lib/grafana/
mkdir /etc/grafana
cp /install/grafana.ini /etc/grafana/
mkdir /etc/service/grafana
cp /install/grafana.sh /etc/service/grafana/run
apk del go git gcc musl-dev nodejs make g++

# Clean up
rm -rf /install
rm -rf /tmp/*
rm -rf /var/cache/apk/*