# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg-utils

DESCRIPTION="Reverse engineering tool for linux games"
HOMEPAGE="https://github.com/korcankaraokcu/PINCE"

SRC_URI="https://github.com/korcankaraokcu/PINCE/releases/download/v${PV}/PINCE-x86_64.AppImage -> ${P}.AppImage"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip"

RDEPEND="sys-libs/zlib"

QA_PREBUILT="*"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${S}"
	chmod +x "${P}.AppImage" || die "Failed to chmod +x for AppImage!"
	
	./"${P}.AppImage" --appimage-extract >/dev/null 2>&1 || die "Failed to unpack AppImage"
	
	mv squashfs-root/* .
	rm squashfs-root/.DirIcon
	rmdir squashfs-root
}

src_install() {
	doicon usr/share/icons/hicolor/scalable/apps/PINCE.svg
	domenu PINCE.desktop

	into "/opt/${PN}"
	# For some reason into *does not* set the path for doins & doexe... Some bug perhaps...
	insinto "/opt/${PN}"
	exeinto "/opt/${PN}"
	
	sed -i -e 's|^export APPDIR.*|export APPDIR="'/opt/${PN}'"|g' AppRun || die "Failed to patch AppRun"
	
	doexe AppRun
	doins -r opt usr
	
	fperms +x /opt/${PN}/usr/bin/*
	
	#~ make_wrapper pince "/opt/${PN}/AppRun"
	
	dosym /opt/${PN}/AppRun usr/bin/pince
	
}

pkg_postinst() {
	xdg_icon_cache_update
	udev_reload
}

pkg_postrm() {
	xdg_icon_cache_update
	udev_reload
}

