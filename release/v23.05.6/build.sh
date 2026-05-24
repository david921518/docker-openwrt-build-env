#!/bin/bash

sudo apt update && sudo apt install libelf1

git clone -b v23.05.6 https://git.openwrt.org/openwrt/openwrt.git openwrt-v23.05.5
cd openwrt-v23.05.6

wget https://downloads.openwrt.org/releases/23.05.6/targets/x86/64/config.buildinfo
cp -f config.buildinfo .config

./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a

patch -p1 < ../0001_enable-ACL-and-Security-labels-by-default.patch

make oldconfig

make -j4 2>&1 | tee b.log
