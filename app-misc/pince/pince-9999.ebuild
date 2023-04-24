# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 wrapper

DESCRIPTION="Reverse engineering tool for linux games"
HOMEPAGE="https://github.com/korcankaraokcu/PINCE"
EGIT_REPO_URI="https://github.com/korcankaraokcu/PINCE.git"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-devel/gdb
		dev-util/scanmem
		dev-python/PyQt6
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_install() {
	exeinto "/opt/PINCE"
	insinto "/opt/PINCE"
	
	doexe PINCE.py PINCE.sh
	doins __init__.py
	
	doins -r libpince GUI
	
	
	make_wrapper "${PN}" "sudo /opt/PINCE/PINCE.sh" "/opt/PINCE"
	
	elog "PINCE has to be run as root and its wrapper script contains sudo/gksudo"
	elog "so if you don't want to input password everytime you run it, add following"
	elog "to your sudoers:"
	elog "  %wheel ALL=(ALL)  NOPASSWD: /opt/PINCE/PINCE.sh"
	
	#~ doins -r "usr/share/icons"
	
	#~ insinto "/usr/share/applications"
	#~ doins -r "usr/share/applications"
	
	#~ for F in chrome-sandbox chrome_crashpad_handler lycheeslicer; do
		#~ fperms 755 "/opt/LycheeSlicer/${F}" 
	#~ done
	
	#~ fperms 4755 "/opt/LycheeSlicer/chrome-sandbox"
	
	#~ dosym "/opt/LycheeSlicer/lycheeslicer" "/usr/bin/lycheeslicer"
}
