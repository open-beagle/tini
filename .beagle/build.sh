#!/usr/bin/env bash

set -ex

apt-get update -y
apt-get install -y cmake git

LOCAL_ARCH=$(uname -m)
GITCOMMIT=${GITCOMMIT:-$(git rev-parse --short HEAD 2> /dev/null || true)}

if [[ "$LOCAL_ARCH" = "x86_64" ]]; then
  TARGET_ARCH="amd64"
elif [[ "$(echo $LOCAL_ARCH | head -c 5)" = "armv8" ]]; then
  TARGET_ARCH="arm64"
elif [[ "$LOCAL_ARCH" = "aarch64" ]]; then
  TARGET_ARCH="arm64"
elif [[ "$LOCAL_ARCH" = "ppc64le" ]]; then
  TARGET_ARCH="ppc64le"
elif [[ "$LOCAL_ARCH" = "mips64" ]]; then
  TARGET_ARCH="mips64le"
else
  echo "This system's architecture $(LOCAL_ARCH) isn't supported"
  TARGET_ARCH="unsupported"
  exit 0 
fi

cmake .
make clean
make tini-static
mkdir -p dist/linux-$TARGET_ARCH/
mv tini-static dist/linux-$TARGET_ARCH/tini-static
