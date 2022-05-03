if [[ ! -d td ]]; then
  git clone https://github.com/tdlib/td.git
  # v1.8.0
  (cd td && git checkout b3ab664a18f8611f4dfcd3054717504271eeaa7a)
fi

docker run -ti --rm --name tdlib -v ${PWD}/build_tdlib.sh:/build.sh -v ${PWD}/td:/td ubuntu:20.04 /build.sh
