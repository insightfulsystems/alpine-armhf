#!/bin/sh

set -e

[ $(id -u) -eq 0 ] || {
	printf >&2 '%s requires root\n' "$0"
	exit 1
}

usage() {
	printf >&2 '%s: [-r release] [-m mirror] [-s]  [-c additional repository]\n' "$0"
	exit 1
}

tmp() {
	echo "Creating temporary files"
	TMP=$(mktemp -d ${TMPDIR:-/var/tmp}/alpine-docker-XXXXXXXXXX)
	ROOTFS=$(mktemp -d ${TMPDIR:-/var/tmp}/alpine-docker-rootfs-XXXXXXXXXX)
	trap "rm -rf $TMP $ROOTFS" EXIT TERM INT
}

apkv() {
	curl -vsSL $MAINREPO/$ARCH/APKINDEX.tar.gz | tar -Oxz |
		grep --text '^P:apk-tools-static$' -A1 | tail -n1 | cut -d: -f2
}

getapk() {
	echo "Getting APK"
	curl -vsSL $MAINREPO/$ARCH/apk-tools-static-$(apkv).apk |
		tar -xz -C $TMP sbin/apk.static
}

mkbase() {
	echo "Getting alpine-base"
	$TMP/sbin/apk.static --repository $MAINREPO --update-cache --allow-untrusted \
		--root $ROOTFS --initdb add alpine-base 
}

conf() {
	echo "Setting config"
	printf '%s\n' $MAINREPO > $ROOTFS/etc/apk/repositories
	printf '%s\n' $ADDITIONALREPO >> $ROOTFS/etc/apk/repositories
}

quickdocker() {
	local id
	id=$(tar --numeric-owner -C $ROOTFS -c . | docker import - alpine:$REL-$ARCH)

	docker tag $id alpine:$REL-$ARCH
	docker run -i -t --rm alpine printf 'alpine:%s-%s with id=%s created!\n' $REL $ARCH $id
}

save() {
	[ $SAVE -eq 1 ] || return

	echo "Packing rootfs"
	tar --numeric-owner -C $ROOTFS -c . | xz -9 -c > rootfs.tar.xz
}

while getopts "hr:m:s" opt; do
	case $opt in
		r)
			REL=$OPTARG
			;;
		m)
			MIRROR=$OPTARG
			;;
		s)
			SAVE=1
			;;
		c)
			ADDITIONALREPO=community
			;;
		*)
			usage
			;;
	esac
done

REL=${REL:-edge}
MIRROR=${MIRROR:-http://nl.alpinelinux.org/alpine}
SAVE=${SAVE:-0}
MAINREPO=$MIRROR/$REL/main
ADDITIONALREPO=$MIRROR/$REL/community
ARCH=${ARCH:-$(uname -m)}

tmp
getapk
mkbase
conf
save
