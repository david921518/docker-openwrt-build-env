#!/bin/bash

sudo apt update && sudo apt install libelf1

git clone -b v24.10.6 https://git.openwrt.org/openwrt/openwrt.git openwrt-v24.10.6
cd openwrt-v24.10.6

wget https://downloads.openwrt.org/releases/24.10.6/targets/x86/64/config.buildinfo
cp -f config.buildinfo .config

./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

patch -p1 < ../0001_enable-apk-package.patch

make oldconfig

make -j1 V=s 2>&1 | tee b.log

make -j4 2>&1 | tee b.log
