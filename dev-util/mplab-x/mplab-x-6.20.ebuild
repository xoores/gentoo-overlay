# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION="MPLAB X Integrated Development Environment (IDE) from Microchip"
HOMEPAGE="https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide"
SRC_URI="https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/MPLABX-v${PV}-linux-installer.tar"



LICENSE="MPLAB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist splitdebug fetch"

pkg_nofetch() {
	elog "Unfortunately I cannot easily fetch the installer, because for some reason Microchip feels"
	elog "the need to check referers... So in order to continue with this instalation, you have to"
	elog "download the installer from here:"
	elog "    ${HOMEPAGE}"
	elog "Then copy the downloaded package to /var/cache/distfiles"
	elog ""
	elog "Alternatively you can try to pull the package directly using following command:"
	echo "  wget --header=\"Referer: https://www.microchip.com/\" \\"
	echo "       -O /var/cache/distfiles/ \\"
	echo "       \"${SRC_URI}\""
	echo
	
}

S="${WORKDIR}/"

src_install() {
	#~ bash "MPLABX-v${PV}-linux-installer.sh" --nolibrarycheck --nox11 --noexec --target "${S}"
	
	bash "MPLABX-v${PV}-linux-installer.sh" --nolibrarycheck --nox11 \
			-- --unattendedmodeui none --mode unattended \
			--collectInfo 0 --collectMyMicrochipInfo 0 \
			--installdir "${D}/opt/microchip/mplabx/v6.20"
}
