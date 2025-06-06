# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop readme.gentoo-r1 wrapper xdg-utils

DESCRIPTION="Intelligent Python IDE with unique code assistance and analysis"
HOMEPAGE="https://www.jetbrains.com/pycharm/"
SRC_URI="https://download.jetbrains.com/python/${P}.tar.gz"

LICENSE="|| ( PyCharm_Academic PyCharm_Classroom PyCharm PyCharm_OpenSource PyCharm_Preview )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+bundled-jdk"

BDEPEND="dev-util/patchelf"

RDEPEND="!bundled-jdk? ( >=virtual/jre-1.8 )
	app-arch/brotli
	app-arch/zstd
	app-crypt/p11-kit
	dev-libs/fribidi
	dev-libs/glib
	dev-libs/json-c
	dev-libs/libbsd
	dev-libs/libdbusmenu
	dev-libs/nss
	dev-python/pip
	media-fonts/dejavu
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype:2=
	media-libs/harfbuzz
	media-libs/libglvnd
	media-libs/libpng:0=
	net-libs/gnutls
	net-print/cups
	sys-apps/dbus
	sys-libs/libcap
	sys-libs/zlib
	virtual/jpeg:0=
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango
"

RESTRICT="mirror"

QA_PREBUILT="opt/${P}/*"

MY_PN=${PN/-professional/}
S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	default

	rm -vf "${S}"/help/ReferenceCardForMac.pdf || die

	rm -vf "${S}"/bin/fsnotifier || die
	rm -vf "${S}"/bin/phpstorm.vmoptions || die

	rm -vf "${S}"/plugins/performanceTesting/bin/libyjpagent.so || die
	rm -vf "${S}"/plugins/performanceTesting/bin/*.dll || die
	rm -vf "${S}"/plugins/performanceTesting/bin/libyjpagent.dylib || die
	rm -vrf "${S}"/lib/pty4j-native/linux/{aarch64,mips64el,ppc64le,x86} || die
	rm -vf "${S}"/plugins/python-ce/helpers/pydev/pydevd_attach_to_process/attach_linux_x86.so

	sed -i \
		-e "\$a\\\\" \
		-e "\$a#-----------------------------------------------------------------------" \
		-e "\$a# Disable automatic updates as these are handled through Gentoo's" \
		-e "\$a# package manager. See bug #704494" \
		-e "\$a#-----------------------------------------------------------------------" \
		-e "\$aide.no.platform.update=Gentoo" bin/idea.properties

	for file in "jbr/lib/"/{libjcef.so,jcef_helper}
	do
		if [[ -f "${file}" ]]; then
			patchelf --set-rpath '$ORIGIN' ${file} || die
		fi
	done
}

src_install() {
	local DIR="/opt/${PN}"
	local JRE_DIR="jbr"

	insinto ${DIR}
	doins -r *

	if ! use bundled-jdk; then
		rm -r "${JRE_DIR}" || die
	fi

	fperms 755 "${DIR}"/bin/{format.sh,inspect.sh,jetbrains_client.sh,ltedit.sh,pycharm,pycharm.sh,remote-dev-server,remote-dev-server.sh,repair,restarter}

	fperms 755 "${DIR}/${JRE_DIR}"/bin/*
	fperms 755 "${DIR}/${JRE_DIR}"/lib/{chrome-sandbox,jcef_helper,jexec,jspawnhelper}

	dosym "${EPREFIX}${DIR}/bin/${PN//-professional/}" "/usr/bin/${PN}"
	newicon bin/${MY_PN}.png ${PN}.png
	make_desktop_entry ${PN} ${PN} ${PN}

	readme.gentoo_create_doc
	

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	dodir /etc/sysctl.d/
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-idea-inotify-watches.conf" || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
