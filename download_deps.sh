#!/bin/sh

set -x

WD=`pwd`

curl -OL 'https://github.com/eycorsican/tun2socks-rs/releases/latest/download/libtun2socks-ios.zip' \
	&& mv libtun2socks-ios.zip /tmp/ \
	&& unzip -o /tmp/libtun2socks-ios.zip -d /tmp \
	&& mv /tmp/libtun2socks.a PacketTunnel/libtun2socks/ \
	&& mv /tmp/tun2socks.h PacketTunnel/libtun2socks/
