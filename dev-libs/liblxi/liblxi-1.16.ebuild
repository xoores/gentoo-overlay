# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson

DESCRIPTION="Simple API for communicating with LXI compatible instruments"
HOMEPAGE="https://lxi-tools.github.io/"
SRC_URI="https://github.com/lxi-tools/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="avahi static-libs"

DEPEND="
	avahi? ( net-dns/avahi )
	dev-libs/libxml2
	"
RDEPEND="${DEPEND}"

src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
