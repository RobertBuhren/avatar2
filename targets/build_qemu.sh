#!/bin/bash
source /etc/os-release

if [[ "$ID" == "ubuntu" ]]
then
  sudo bash -c 'echo "deb-src http://archive.ubuntu.com/ubuntu/ '$UBUNTU_CODENAME'-security main restricted" >> /etc/apt/sources.list'
  sudo apt-get update
  sudo apt-get build-dep -y qemu
fi

cd `dirname "$BASH_SOURCE"`/src/
git clone -b fix_glibc27_build --depth 1 git@github.com:RobertBuhren/avatar-qemu.git

cd avatar-qemu

mkdir -p ../../build/qemu/
cd ../../build/qemu
../../src/avatar-qemu/configure --disable-sdl --target-list=arm-softmmu --enable-trace-backends=simple
make -j4

