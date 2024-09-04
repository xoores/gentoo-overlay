# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

DESCRIPTION="Flexible system wide daemon which remaps keys using kernel level input primitives (evdev, uinput)"
HOMEPAGE="https://github.com/rvaiya/keyd"
SRC_URI="https://github.com/rvaiya/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE="systemd"

DEPEND="
	acct-group/keyd
	dev-python/python-xlib
	dev-python/dbus-python
	sys-devel/gcc
	dev-build/cmake
	sys-libs/glibc
"


src_install() {
	dobin bin/*
	dodoc docs/*.md
	
	# Prepare manpages
	for FILE in docs/*.scdoc; do
		TARGET="${FILE%%.scdoc}.1"
		TARGET="data/${TARGET##*/}"
		scdoc < "${FILE}" > "${TARGET}" || die "Failed to make doc $from {FILE}"
		doman "${TARGET}"
	done
	
	# Default config
	insinto /etc/keyd
	doins "${FILESDIR}/default.conf"
	
	insinto /usr/share/keyd
	doins -r layouts examples
	doins data/keyd.compose
	
	if use systemd ; then
		einfo "Installing systemd files"
		insinto /usr/lib/systemd/system/
		doins keyd.service
	else
		einfo "Installing openrc files"
		dodir /etc/init.d
		cp "${FILESDIR}/keyd.initrc" "${D}/etc/init.d/keyd"
		fperms -R 755 /etc/init.d/keyd
	fi
		
	# Quote from README.md:
	#     Experimental support for single board computers (SBCs) via
	#     usb-gadget has been added courtesy of Giorgi Chavchanidze.
	#~ @if [ "$(VKBD)" = "usb-gadget" ]; then \
			#~ install -Dm644 src/vkbd/usb-gadget.service $(DESTDIR)$(PREFIX)/lib/systemd/system/keyd-usb-gadget.service; \
			#~ install -Dm755 src/vkbd/usb-gadget.sh $(DESTDIR)$(PREFIX)/bin/keyd-usb-gadget.sh; \
	#~ fi
}

pkg_postinst() {
	ewarn "Note: It is possible to render your machine unusable with a bad config file."
	ewarn "Should you find yourself in this position, the special key sequence:"
	ewarn "backspace+escape+enter which should cause keyd to terminate."
}
