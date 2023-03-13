# git

```bash
git remote add upstream git@github.com:krallin/tini.git

git fetch upstream

git merge v0.19.0
```

## build

```bash
# amd64
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
-e TINI_VERSION=0.19.0-beagle \
registry.cn-qingdao.aliyuncs.com/wod/debian:bullseye-amd64 \
bash .beagle/build.sh

# arm64
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
registry.cn-qingdao.aliyuncs.com/wod/debian:bullseye-arm64 \
bash .beagle/build.sh

# ppc64le
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
registry.cn-qingdao.aliyuncs.com/wod/debian:bullseye-ppc64le \
bash .beagle/build.sh

# mips64le
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
registry.cn-qingdao.aliyuncs.com/wod/debian:bullseye-mips64le \
bash .beagle/build.sh
```

## test

```bash
# amd64
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
registry.cn-qingdao.aliyuncs.com/wod/debian:bullseye-amd64 \
dist/linux-amd64/tini-static --version

# arm64
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
registry.cn-qingdao.aliyuncs.com/wod/debian:bullseye-amd64 \
dist/linux-arm64/tini-static --version

# ppc64le
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
registry.cn-qingdao.aliyuncs.com/wod/debian:bullseye-ppc64le \
dist/linux-ppc64le/tini-static --version

# mips64le
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
registry.cn-qingdao.aliyuncs.com/wod/debian:bullseye-mips64le \
dist/linux-mips64le/tini-static --version
```
