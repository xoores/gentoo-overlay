# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Common code used by libimobiledevice project.."
HOMEPAGE="https://github.com/libimobiledevice/libimobiledevice-glue"

EGIT_REPO_URI="https://github.com/libimobiledevice/libimobiledevice-glue.git"
EGIT_COMMIT="114098d30e783fbb3def5c9b49427a86621cfcb1"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="udev"

inherit autotools git-r3


DEPEND="app-pda/libplist
	sys-libs/readline
	virtual/libusb:1"
RDEPEND="${DEPEND}"

#S="${WORKDIR}/${PN}"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	rm "${D}/usr/$(get_libdir)/${PN}-1.0.la" || die
}
