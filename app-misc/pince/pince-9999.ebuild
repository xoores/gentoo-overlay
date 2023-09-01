# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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
		dev-libs/distorm3
		dev-python/PyQt6
		dev-python/pygdbmi
		dev-python/keyboard
		dev-python/pygobject
		dev-util/intltool
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_compile() {
	# Welp, PINCE does *not* work with scanmem-0.17 (throws an undefined
	# symbol error) so we need to build the version that is used as module
	# in PINCE repo... -.-
	
	cd scanmem
	sh autogen.sh || die "Failed to autogen scanmem"
	./configure --prefix="$(pwd)" || die "Failed to ./configure scanmem"
	make -j libscanmem.la || die "Failed to make scanmem"
}

src_install() {
	exeinto "/opt/PINCE"
	insinto "/opt/PINCE"
	
	# We could use the system libscanmem.so - if it worked -.-
	#sed -i  's|^\([[:space:]]*libscanmem_path = \).*$|\1"/usr/lib64/libscanmem.so"|g' PINCE.py

	
	doexe PINCE.py PINCE.sh
	doins __init__.py COPYING AUTHORS THANKS
	
	
	# Necessary steps, hiden nicely in install_pince.sh 
	mkdir libpince/libscanmem/
	cp -p scanmem/gui/scanmem.py libpince/libscanmem
	cp -p scanmem/gui/misc.py libpince/libscanmem
	cp -pL scanmem/.libs/libscanmem.so libpince/libscanmem
	
	# required for relative import, since it will throw an import error
	# if it's just `import misc`
	sed -i 's/import misc/from \. import misc/g' libpince/libscanmem/scanmem.py
	
	doins -r libpince GUI
	
	
	make_wrapper "${PN}" "sudo /opt/PINCE/PINCE.sh" "/opt/PINCE"
	
	elog "PINCE has to be run as root and its wrapper script contains sudo/gksudo"
	elog "so if you don't want to input password everytime you run it, add following"
	elog "to your sudoers:"
	elog "  %wheel ALL=(ALL)  NOPASSWD: /opt/PINCE/PINCE.sh"
}
