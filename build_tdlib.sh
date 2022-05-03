#!/bin/bash

apt-get update
apt-get upgrade
apt-get install -y make git zlib1g-dev libssl-dev gperf php-cli cmake clang-10 libc++-dev libc++abi-dev

git clone https://github.com/tdlib/td.git
cd td
# v1.8.0
git checkout b3ab664a18f8611f4dfcd3054717504271eeaa7a

cd td
rm -rf build
mkdir build
cd build

MODE=$1
if [[ $MODE == "32bit" ]]; then
  # On rpi
  # ln -s /usr/bin/clang++-10 /usr/bin/clang++
  # ln -s /usr/bin/clang-10 /usr/bin/clang
  sed -i "378i else()\n  target_link_libraries(tdutils PUBLIC atomic)" /td/tdutils/CMakeLists.txt
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib -DTD_ENABLE_LTO=ON ..
  cmake --build . --target prepare_cross_compiling -j $(nproc)
  cd ..
  php SplitSource.php
  cd build
  cmake --build . --target install -j $(nproc)
  cd ..
  php SplitSource.php --undo
else
  CXXFLAGS="-stdlib=libc++" CC=/usr/bin/clang-10 CXX=/usr/bin/clang++-10 cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib ..
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib ..
  cmake --build . --target install
fi
