# Ebuild for EdrawMax
#
# Description: Quite nice all-in-one diagramming tool and an alternative 
#			   to Micsrosoft Visio. EdrawMax is available for MacOS, Linux
#			   and also Windows.
#
# Maintainer: Xoores <gentoo@xoores.cz>


EAPI=8

inherit rpm xdg-utils

#MY_PV=$(ver_rs 1-2 '-')

#~ SRC_URI="https://download.edrawsoft.com/archives/edrawmax_en_full5371.rpm -> ${P}.rpm"
SRC_URI="https://download.wondershare.com/prd/edrawmax_full5371.rpm -> ${P}.rpm"
DESCRIPTION="All-in-one Diagramming Tool, nice alternative to Microsoft Visio"
HOMEPAGE="https://www.edrawsoft.com/"

LICENSE="EULA"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror"

IUSE="-mysql -postgres"

RDEPEND="
	app-accessibility/at-spi2-core
	app-arch/brotli
	app-arch/bzip2
	app-arch/zstd
	app-crypt/mit-krb5
	dev-libs/double-conversion
	dev-libs/expat
	dev-libs/glib
	dev-libs/icu
	dev-libs/libffi
	dev-libs/libpcre2
	dev-libs/libunistring
	dev-libs/nspr
	dev-libs/nss
	dev-libs/openssl
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtgamepad:5
	dev-qt/qt3d:5
	dev-qt/qtsensors:5
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libglvnd
	media-libs/libpng
	media-libs/mesa
	media-video/rtmpdump
	net-dns/avahi
	net-dns/c-ares
	net-dns/libidn2
	net-libs/libpsl
	net-libs/libssh2
	net-libs/nghttp2
	net-libs/nghttp3
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-apps/keyutils
	sys-apps/util-linux
	sys-devel/gcc
	sys-fs/e2fsprogs
	sys-libs/glibc
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pixman

	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
"


S="${WORKDIR}/"
EDRAW_OPTDIR="EdrawMax-$(ver_cut 1)"
EDRAW_OPTDIR="EdrawMax-13"


src_unpack() {
    rpm_src_unpack ${A}
}

src_prepare()
{
	default
	
	# Remove unused plugins/drivers. Yeah yeah, I might do this by not 
	# calling doins on everything, but hey.
	# Also BE WARNED: I did not test neither of these as I don't need
	# that functionality but feel free to test & do a pull request :)
	if ! use mysql; then
		rm "opt/apps/edrawmax/lib/sqldrivers/libqsqlmysql.so"
	fi
	
	#~ if ! use postgres; then
		#~ rm "opt/${EDRAW_OPTDIR}/plugins/sqldrivers/libqsqlpsql.so"
	#~ fi
	
	
	#~ # TODO: try to find out missing dependencies:
    #~ #         - libQt53DQuick.so.5
    #~ #		  - llibQt53DQuickScene2D.so.5
	#~ rm "opt/${EDRAW_OPTDIR}/plugins/renderplugins/libscene2d.so"
		
	# Remove CRs from Edrawmaxes desktop file...
	sed -i \
		-e 's/\r$//' \
		-e "s|Exec=.*|Exec=/opt/${PN}/EdrawMax %F|g" \
		-e "s|Icon=.*|Icon=/opt/${PN}/edrawmax.png|g" \
		usr/share/applications/edrawmax.desktop 
}

src_install() {
	insinto /opt/${PN}
	
	#~ doins -r opt/${EDRAW_OPTDIR}/*
	doins -r opt/apps/edrawmax/*

	fperms 755 /opt/${PN}/EdrawMax
	fperms -R 755 /opt/${PN}/lib
	
	# Since I'm lazy & don't wanna edit PATH
	dosym /opt/${PN}/EdrawMax /usr/bin/edrawmax
	
	
	insinto /
	
	doins -r usr/
}


pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
