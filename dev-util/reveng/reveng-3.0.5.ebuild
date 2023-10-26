# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Arbitrary-precision CRC calculator and algorithm finder"
HOMEPAGE="https://reveng.sourceforge.io"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ppc ppc64 sparc x86"
IUSE="+man"

DEPEND="
	man? ( || ( app-text/pandoc app-text/pandoc-bin dev-haskell/pandoc ) )
	"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	
	if use amd64 || arm64 || ia64 || ppc64; then 
		einfo "Patching config.h for 64bit architecture..."
		
		sed -i 's|^#define BMP_BIT[\ ]*32$|#define BMP_BIT 64|g' config.h ||\
			die "Failed to path BMP_BIT in config.h"
			
		sed -i 's|^#define BMP_SUB[\ ]*16$|#define BMP_SUB 32|g' config.h ||\
			die "Failed to path BMP_SUB in config.h"
	fi
}


src_install() {
	
	exeinto "/usr/bin"
	dobin "${PN}"
	
	dodoc README COPYING CHANGES
	
	if use man; then
		pandoc --standalone --to man README -o reveng.1
		doman reveng.1
	fi
}
