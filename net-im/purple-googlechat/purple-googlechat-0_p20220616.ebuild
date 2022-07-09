# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Hangouts GoogleChat for libpurple"
HOMEPAGE="https://github.com/EionRobb/purple-googlechat"

COMMIT="dfdd9c9a428b89e2982814a9c82e3dde117be84f"
SRC_URI="https://github.com/EionRobb/purple-googlechat/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/protobuf-c:=
	net-im/pidgin
	sys-libs/zlib"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	# Does not respect CFLAGS
	sed -i Makefile -e 's/-g -ggdb//g' || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_install() {
	emake \
		PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		DESTDIR="${ED}" \
		install

	einstalldocs
}
