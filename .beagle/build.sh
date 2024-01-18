#!/usr/bin/env bash

set -ex

apt-get update -y
apt-get install -y cmake git libc6-dev

GITCOMMIT=${GITCOMMIT:-$(git rev-parse --short HEAD 2> /dev/null || true)}

LOCAL_ARCH=$(uname -m)
if [ "$LOCAL_ARCH" = "x86_64" ]; then
  TARGET_ARCH="amd64"
elif [ "$(echo $LOCAL_ARCH | head -c 5)" = "armv8" ]; then
  TARGET_ARCH="arm64"
elif [ "$LOCAL_ARCH" = "aarch64" ]; then
  TARGET_ARCH="arm64"
elif [ "$LOCAL_ARCH" = "loongarch64" ]; then
  TARGET_ARCH="loong64"
elif [ "$(echo $LOCAL_ARCH | head -c 5)" = "ppc64" ]; then
  TARGET_ARCH="ppc64le"
elif [ "$(echo $LOCAL_ARCH | head -c 6)" = "mips64" ]; then
  TARGET_ARCH="mips64le"
else
  TARGET_ARCH="unsupported"
fi
if [ "$TARGET_ARCH" = "unsupported" ]; then
  echo "This system's architecture ${LOCAL_ARCH} isn't supported"
  exit 0
fi

cmake .
make clean
make tini-static
mkdir -p dist/linux-$TARGET_ARCH/
mv tini-static dist/linux-$TARGET_ARCH/tini-static
