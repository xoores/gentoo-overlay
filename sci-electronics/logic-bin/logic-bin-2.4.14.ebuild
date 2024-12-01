# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils udev

DESCRIPTION="Saleae Logic 2 logical analyzer GUI"
HOMEPAGE="https://www.saleae.com"

SRC_URI="https://downloads.saleae.com/logic2/Logic-${PV}-linux-x64.AppImage -> ${P}.AppImage"

S="${WORKDIR}"
LICENSE="Saleae"
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
	doicon usr/share/icons/hicolor/256x256/apps/Logic.png
	domenu Logic.desktop

	into "/opt/${PN}"
	# For some reason into *does not* set the path for doins & doexe... Some bug perhaps...
	insinto "/opt/${PN}"
	exeinto "/opt/${PN}"
	
	doexe Logic chrome-sandbox chrome_crashpad_handler usr/lib/* *.so *.so.*
	
	doins -r LICENSE \
			chrome_100_percent.pak \
			chrome_200_percent.pak \
			icudtl.dat \
			locales \
			resources \
			resources.pak \
			snapshot_blob.bin \
			v8_context_snapshot.bin \
			version \
			vk_swiftshader_icd.json
	
	dosym /opt/${PN}/Logic usr/bin/logic
	
	insinto  /lib/udev/rules.d/
	doins "${FILESDIR}/95-saleae.rules"
}

pkg_postinst() {
	xdg_icon_cache_update
	udev_reload
}

pkg_postrm() {
	xdg_icon_cache_update
	udev_reload
}

