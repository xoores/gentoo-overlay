# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#~ inherit flag-o-matic meson

DESCRIPTION="Easily transfer content into the FBX format "
HOMEPAGE="https://aps.autodesk.com/developer/overview/fbx-sdk"
SRC_URI="https://damassets.autodesk.net/content/dam/autodesk/www/files/fbx${PV//./}_fbxsdk_gcc_linux.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
#~ IUSE="avahi static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

#~ src_configure() {
	#~ meson_src_configure
#~ }

#~ src_compile() {
	#~ meson_src_compile
#~ }

src_install() {
	#~ meson_src_install
	TGT="/opt/fbx${PV//./}"
	dodir "${TGT}"
	yes yes | ./fbx202037_fbxsdk_linux "${D}/${TGT}"
	chmod -R ugo-w "${D}/${TGT}"
}
