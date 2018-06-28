#!/bin/bash
# 
# Prepare build environment for different architectures,
# such as arm64(x86_64) and aarch64(arm64)
#
# (c) 2018 - Dumi Loghin
#
ARCH=`uname -m`
CDIR=`pwd`
SDIR=`dirname $0`
# go to images/javaenv
cd $SDIR
if [ "$ARCH" == "armv7l" ]; then
	cd ../../
	cp precompiled/armv7l/* build/image/javaenv/
	cd images/javaenv
	rm -f Dockerfile.in
	cp Dockerfile.in.armv7l Dockerfile.in
	cd ../../core/chaincode/shim/java
	rm -f build.gradle
	cp build.gradle.aarch64 build.gradle
elif [ "$ARCH" == "aarch64" ]; then
	# go to parent
	cd ../../
	cp precompiled/aarch64/* build/image/javaenv/
	cd images/javaenv
	rm -f Dockerfile.in
	cp Dockerfile.in.aarch64 Dockerfile.in
	cd ../../core/chaincode/shim/java
	rm -f build.gradle
	cp build.gradle.aarch64 build.gradle 
elif [ "$ARCH" == "x86_64" ]; then	
	rm -f Dockerfile.in
        cp Dockerfile.in.amd64 Dockerfile.in
	cd ../../core/chaincode/shim/java
        rm -f build.gradle
        cp build.gradle.amd64 build.gradle
fi
cd $CDIR
