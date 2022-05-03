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

CXXFLAGS="-stdlib=libc++" CC=/usr/bin/clang-10 CXX=/usr/bin/clang++-10 cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib ..
cmake --build . --target install
