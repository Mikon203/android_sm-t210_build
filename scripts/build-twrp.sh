#!/bin/bash
# Runs inside an ubuntu:16.04 container (old toolchain for Android 5.1).
set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev \
  gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev \
  lib32z1-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip openjdk-8-jdk python bc \
  rsync schedtool squashfs-tools imagemagick libssl-dev lzop
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
export LC_ALL=C
export ALLOW_MISSING_DEPENDENCIES=true
export USE_CCACHE=1
export CCACHE_DIR=/root/.ccache
ccache -M 8G
java -version
cd /twrp
set +e
source build/envsetup.sh
set -e
lunch omni_lt02-eng
mka recoveryimage -j"$(nproc)"
