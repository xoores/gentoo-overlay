# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Binary Ninja is an interactive decompiler, disassembler, debugger, and binary analysis platform built by reverse engineers, for reverse engineers."
HOMEPAGE="https://binary.ninja"

SRC_URI="binaryninja_personal_linux.zip"

LICENSE="|| ( BinaryNinja_Personal )"
SLOT="0"
KEYWORDS="amd64 x86"


RDEPEND=""

RESTRICT="mirror"

QA_PREBUILT="opt/binaryninja/*"

S="${WORKDIR}/binaryninja"

pkg_nofetch() {
	einfo "BinaryNinja has no licensing in software - you get personalized download link when"
	einfo "you purchase your license. Please download it and put the downloaded file"
	einfo "in DISTDIR (usually /var/cache/distfiles/)"
}


src_install() {
	insinto "/opt/binaryninja"
	doins -r *

	fperms 755 "/opt/binaryninja/binaryninja"

	make_wrapper "binaryninja" "/opt/binaryninja/binaryninja"
}
