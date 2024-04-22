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

SRC_URI="https://download.edrawsoft.com/archives/edrawmax_${PV}_en_x86_64.rpm  -> ${P}.rpm"
DESCRIPTION="All-in-one Diagramming Tool, nice alternative to Microsoft Visio"
HOMEPAGE="https://www.edrawsoft.com/"

LICENSE="EULA"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror"

IUSE="-mysql -postgres"

RDEPEND="
	dev-qt/qtsensors:5
	dev-qt/qtserialport:5
	dev-qt/designer:5
	dev-qt/qt3d:5
	dev-qt/qtgamepad:5
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
"


S="${WORKDIR}/"
EDRAW_OPTDIR="EdrawMax-$(ver_cut 1)"


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
		rm "opt/${EDRAW_OPTDIR}/plugins/sqldrivers/libqsqlmysql.so"
	fi
	
	if ! use postgres; then
		rm "opt/${EDRAW_OPTDIR}/plugins/sqldrivers/libqsqlpsql.so"
	fi
	
	
	# TODO: try to find out missing dependencies:
    #         - libQt53DQuick.so.5
    #		  - llibQt53DQuickScene2D.so.5
	rm "opt/${EDRAW_OPTDIR}/plugins/renderplugins/libscene2d.so"
		
	# Remove CRs from Edrawmaxes desktop file...
	sed -i \
		-e 's/\r$//' \
		-e "s|Exec=.*|Exec=/opt/${PN}/EdrawMax %F|g" \
		-e "s|Icon=.*|Icon=/opt/${PN}/edrawmax.png|g" \
		usr/share/applications/edrawmax.desktop 
}

src_install() {
	insinto /opt/${PN}
	
	doins -r opt/${EDRAW_OPTDIR}/*

	fperms 755 /opt/${PN}/EdrawMax
	fperms -R 755 /opt/${PN}/lib
	
	# Since I'm lazy & don't wanna edit PATH
	dosym /opt/${PN}/EdrawMax /usr/bin/edrawmax
	
	insinto  /usr/share/mime/packages/
	doins "${FILESDIR}"/${PN}.xml
	
	insinto  /usr/share/applications/
	doins usr/share/applications/edrawmax.desktop
	
	# Prepare all icon sizes, original is 256x256
	convert "${S}/opt/${EDRAW_OPTDIR}/${PN}.ico" "${WORKDIR}/${PN}.png"
	local s SIZES=(16 22 24 32 36 48 64 72 96 128 192 256)
	for s in "${SIZES[@]}"; do
		convert "${WORKDIR}/${PN}-0.png" -resize ${s}x${s} "${WORKDIR}/${PN}_${s}.png"
		newicon --size ${s} --context mimetypes  "${WORKDIR}/${PN}_${s}.png"  application-x-eddx.png
	done

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
