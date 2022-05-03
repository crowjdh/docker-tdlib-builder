#!/bin/bash

docker run -ti --rm \
  --name tdlib \
  -v ${PWD}/build_tdlib.sh:/build.sh \
  -v ${PWD}/td:/td \
  ubuntu:18.04 \
  /build.sh 32bit
