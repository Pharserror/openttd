#!/bin/bash
set -e
source /tmp/buildconfig
set -x

## Temporarily disable dpkg fsync to make building faster.
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

## Enable Ubuntu Universe and Multiverse.
sed -i 's/^#\s*\(deb.*restricted\)$/\1/g' /etc/apt/sources.list
apt-get update

## Install things we need
$minimal_apt_get_install wget unzip libfontconfig1 libfreetype6 liblzo2-2 libsdl1.2debian

## Install libicu52
wget -q http://launchpadlibrarian.net/201330288/libicu52_52.1-8_amd64.deb
dpkg -i libicu52_52.1-8_amd64.deb

## Create user
mkdir -p /home/openttd/.openttd
useradd -M -d /home/openttd -u 911 -U -s /bin/false openttd
usermod -G users openttd
chown openttd:openttd /home/openttd -R

## Download and install openttd
wget -q http://binaries.openttd.org/releases/$OPENTTD_VER/openttd-$OPENTTD_VER-linux-ubuntu-trusty-amd64.deb
dpkg -i openttd-$OPENTTD_VER-linux-ubuntu-trusty-amd64.deb
mkdir -p /etc/service/openttd/

## Download GFX and install
mkdir -p /usr/share/games/openttd/baseset/
cd /usr/share/games/openttd/baseset/
wget -q http://binaries.openttd.org/extra/opengfx/0.5.2/opengfx-0.5.2-all.zip
unzip opengfx-0.5.2-all.zip
tar -xf opengfx-0.5.2.tar
rm -rf opengfx-0.5.2-all.zip opengfx-0.5.2.tar
