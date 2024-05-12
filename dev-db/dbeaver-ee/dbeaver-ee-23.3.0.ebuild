# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit xdg



DESCRIPTION="Comprehensive database management tool, Enterprise Edition"
HOMEPAGE="https://dbeaver.com"
SRC_URI="https://dbeaver.com/files/${PV}/${P}-linux.gtk.x86_64-nojdk.tar.gz"
LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

IUSE=""

DEPEND=">=virtual/jre-1.7:*
	>=x11-libs/gtk+-2:2
	app-crypt/libsecret"
RDEPEND="${DEPEND}"

S="${WORKDIR}/dbeaver"

QA_PREBUILT="*"

src_install() {
	sed -i "s:/usr/share/${PN}/:/opt/${PN}/:" "${PN}.desktop"
	#sed -i "/WM_CLASS/d" "${PN}.desktop"
	insinto "/opt/${PN}"
	exeinto "/opt/${PN}"
	doins -r \
		"configuration" \
		"${PN}.desktop" \
		"dbeaver.ini" \
		"dbeaver.png" \
		"features" \
		"icon.xpm" \
		"licenses" \
		"p2" \
		"plugins" \
		"features" \
		"drivers" \
		"readme.txt"
	doexe "dbeaver"
	dosym "/opt/${PN}/dbeaver" "/usr/bin/dbeaver"
	dosym "/opt/${PN}/dbeaver.desktop" "/usr/share/applications/dbeaver.desktop"
}

pkg_postinst() {
	xdg_desktop_database_update
}
pkg_postrm() {
	xdg_desktop_database_update
}
