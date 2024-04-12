# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A powerful and versatile slicer"
HOMEPAGE="https://easyeda.com"
RESTRICT="bindist mirror"

SRC_URI="https://image.easyeda.com/files/${PN}-linux-x64-${PV}.zip -> ${P}.zip"

KEYWORDS="~amd64"

# I honestly have no idea what the license is :-( Sorry...
LICENSE="GPL-3+"
SLOT="0"

S="${WORKDIR}"

src_install() {
	insinto "/opt"
	doins -r "${PN}"
	
	
	for F in chrome-sandbox chrome_crashpad_handler "${PN}"; do
		fperms 755 "/opt/${PN}/${F}" 
	done
	
	
	dosym "/opt/${PN}/${PN}" "/usr/bin/${PN}"
}
