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

# loong64
docker run -it --rm \
-v $PWD/:/go/src/github.com/krallin/tini \
-w /go/src/github.com/krallin/tini \
cr.loongnix.cn/library/debian:buster \
bash .beagle/build.sh

docker build \
  --build-arg BASE=registry-vpc.cn-qingdao.aliyuncs.com/wod/alpine:3-mips64le \
  --build-arg AUTHOR=mengkzhaoyun@gmail.com \
  --build-arg VERSION=v0.19.0 \
  --build-arg TARGETOS=linux \
  --build-arg TARGETARCH=loong64 \
  --tag registry-vpc.cn-qingdao.aliyuncs.com/wod/tini:v0.19.0-loong64 \
  --file ./.beagle/dockerfile .

docker push registry-vpc.cn-qingdao.aliyuncs.com/wod/tini:v0.19.0-loong64
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

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="tini" \
  -e PLUGIN_MOUNT="./.git" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="tini" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```