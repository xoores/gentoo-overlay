# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake

DESCRIPTION="Apple's implementation of low-level cryptographic primitives"
HOMEPAGE="https://developer.apple.com/security/"
SRC_URI="${PN}.zip"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE=""

DEPEND="
"

S="${WORKDIR}/${PN}"


src_configure() {
	# Patch out some macro that fails under linux...
	sed -i '/^[ ]*CC_MARK_MEMORY_PUBLIC(/d' ccrng/src/ccrng_entropy.c 
	
	#~ mkdir build && cd build
	#~ CC=clang CXX=clang++ cmake ..
	cmake_src_configure
	
	# Patch out _test and _perf, we don't need to compile those
	#~ sed -i '/^\(all\|clean\): CMakeFiles\/corecrypto_\(test\|perf\)/d' CMakeFiles/Makefile2
}

#~ src_compile() {
	#~ cd build
	#~ make
	#~ cmake_src_compile
#~ }

#~ src_install() {
	#~ cd build
	#~ make install
#~ }
