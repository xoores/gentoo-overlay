# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Binary Ninja is an interactive decompiler, disassembler, debugger, and binary analysis platform built by reverse engineers, for reverse engineers."
HOMEPAGE="https://binary.ninja"

# BinaryNinja is not (yet!) available through package-version convention, however
# I did contact them and it seems they may change this in the future. If that is
# the case, I will update this ebuild as well :-)
SRC_URI="https://cdn.binary.ninja/installers/${PN}_free_linux.zip"

LICENSE="|| ( BinaryNinja_Free )"
SLOT="0"
KEYWORDS="amd64 x86"


RDEPEND=""

RESTRICT="mirror"

QA_PREBUILT="opt/${PN}/*"

S="${WORKDIR}/${PN}"


src_install() {
	insinto "/opt/${PN}"
	doins -r *

	fperms 755 "/opt/${PN}/binaryninja"

	make_wrapper "${PN}" "/opt/${PN}/binaryninja"
}
