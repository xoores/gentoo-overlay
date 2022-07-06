# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson

DESCRIPTION="Tools that enables control of LXI compatible instruments"
HOMEPAGE="https://github.com/lxi-tools/lxi-tools"
SRC_URI="https://github.com/lxi-tools/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi +gui"

DEPEND="
	dev-lang/lua:=
	dev-libs/liblxi[avahi=]
	gui? (
		dev-qt/qtcharts
		gui-libs/gtksourceview:5
	)
	"
RDEPEND="${DEPEND}"


src_prepare() {
	default
	eapply "${FILESDIR}"/01-luaversion.patch
}

src_configure() {
	local emesonargs=(
			$(meson_use gui)
			-Dbashcompletiondir=no
	)
	
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
