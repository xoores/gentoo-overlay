# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="A GUI for the Chameleon Ultra/Chameleon Lite written in Flutter for cross platform operation"
HOMEPAGE="https://chameleonultragui.dev"
SRC_URI="https://nightly.link/GameTec-live/ChameleonUltraGUI/workflows/build-app/main/linux-debian.zip"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE=""

DEPEND="
	app-arch/zstd
"
S="${WORKDIR}"

src_unpack() {
	unpack "${A}"
	unpack ./chameleonultragui*.deb
	tar -xf ./data.tar.zst
}

src_prepare() {
	default

	# Patch /usr/local -> /usr
	sed -i 's|/usr/local/lib/|/usr/lib/|g' usr/share/applications/chameleonultragui.desktop
}


src_install() {
        insinto /usr/lib/chameleonultragui
        doins -r usr/local/lib/${PN}/* || die "doins lib failed"
        fperms 755 "/usr/lib/chameleonultragui/chameleonultragui" 
        
        domenu usr/share/applications/chameleonultragui.desktop
        doicon usr/share/icons/chameleonultragui.png
        make_wrapper "${PN}" "/usr/lib/chameleonultragui/chameleonultragui"
}
