# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="All-in-one terminal, sniffer and protocol analyzer"
HOMEPAGE="https://ioninja.com/"
RESTRICT="bindist mirror"

# https://tibbo.com/downloads/archive/ioninja/.internal/prerelease/ioninja-5.3.1-c-linux-amd64.tar.xz
SRC_URI="https://tibbo.com/downloads/archive/${PN}/.internal/prerelease/ioninja-5.3.1-c-linux-${ABI}.tar.xz -> ${P}.tar.xz"

KEYWORDS="amd64 ~arm"

# I honestly have no idea what the license is :-( Sorry...
LICENSE="UNKNOWN"
SLOT="0"
#IUSE="+tdevmon"

RDEPEND="
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtcore:5"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-5.3.1-c-linux-${ABI}"

src_install() {
	doins -r "etc"
	
	# Cannot put stuff in /usr/ *yet* - will be fixed soon
	insinto "/"
	doins -r "share"
	
	for F in bin/*; do
		dobin "${F}"
	done
	
	for F in lib/*; do
		dolib.so "${F}"
	done
}
