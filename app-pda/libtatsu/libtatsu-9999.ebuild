# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#~ inherit autotools toolchain-funcs

DESCRIPTION="Library handling the communication with Apple's Tatsu Signing Server (TSS)."
HOMEPAGE="https://www.libimobiledevice.org/"
#~ SRC_URI="https://github.com/libimobiledevice/${PN}/archive/refs/tags/${PV}.tar.gz  -> ${P}.tar.gz"

EGIT_REPO_URI="https://github.com/libimobiledevice/${PN}.git"
EGIT_BRANCH="master"

inherit autotools toolchain-funcs git-r3

LICENSE="GPL-2+ LGPL-2.1+"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"
SLOT="0"

BDEPEND="
	virtual/pkgconfig
	dev-build/autoconf
	dev-build/automake
	dev-build/libtool
	>=app-pda/libplist-2.6.0
	>=net-misc/curl-7.0
"

src_prepare() {
	./autogen.sh
	
	default
	eautoreconf
}
