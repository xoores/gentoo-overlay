# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

DESCRIPTION="G-code generator for 3D printers (Bambu, Prusa, Voron, VzBot, RatRig, Creality, etc.)"
HOMEPAGE="https://github.com/SoftFever/OrcaSlicer"

SRC_URI="https://github.com/SoftFever/OrcaSlicer/releases/download/v${PV}/OrcaSlicer_Linux_AppImage_V${PV}.AppImage -> ${P}.AppImage"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	dev-libs/libmspack
	media-libs/gstreamer
	app-crypt/libsecret
	media-libs/mesa[X(+)]
	net-libs/webkit-gtk
	dev-libs/openssl
	net-misc/curl
	gui-libs/eglexternalplatform
	virtual/udev
	sys-apps/dbus
	kde-frameworks/extra-cmake-modules
	media-libs/glew
	dev-build/cmake
	dev-vcs/git
	sys-apps/texinfo
"


DEPEND="${RDEPEND}"

QA_PREBUILT="*"
RESTRICT="strip mirror"

S="${WORKDIR}"


src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${WORKDIR}"/ || die
	pushd "${WORKDIR}" || die
	chmod +x "${WORKDIR}/${P}.AppImage" || die
	"${WORKDIR}/${P}.AppImage" --appimage-extract || die
	rm "${WORKDIR}/${P}.AppImage" || die
}


src_install() {
	rm -r squashfs-root/{*.{AppImage,desktop},.DirIcon,usr} || die
	patchelf --replace-needed libwebkit2gtk-4.0.so.37 libwebkit2gtk-4.1.so.0 \
		"${S}/squashfs-root/bin/orca-slicer" || die
	patchelf --replace-needed libjavascriptcoregtk-4.0.so.18 libjavascriptcoregtk-4.1.so.0 \
		"${S}/squashfs-root/bin/orca-slicer" || die
	patchelf --set-rpath '$ORIGIN' \
		"${S}/squashfs-root/bin/orca-slicer" || die

	insinto /opt/orca-slicer
	doins -r "${S}"/squashfs-root/*
	fperms +x "/opt/orca-slicer/AppRun" "/opt/orca-slicer/bin/orca-slicer"
	doicon -s 192 "${S}"/squashfs-root/OrcaSlicer.png
	make_wrapper orca-slicer "/opt/orca-slicer/AppRun"
}
