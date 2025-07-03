# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=no
inherit python-single-r1


DESCRIPTION="DotDotGoose is a free, open source tool to assist with manually counting objects in images"
HOMEPAGE="https://github.com/persts/DotDotGoose"
SRC_URI="https://github.com/persts/DotDotGoose/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="
     ${PYTHON_DEPS}
	>=dev-python/numpy-1.26.4
	>=dev-python/pillow-10.3.0
	>=dev-python/pyqt6-6.7.1
"

S="${WORKDIR}/DotDotGoose-${PV}"


src_install() {
	default
	
	# main.py does not have shebang in the release archive for some reason ?!
	sed -i -e "1i #!/usr/bin/python3" main.py
	
	python_domodule ddg
	python_newscript main.py dotdotgoose
}
