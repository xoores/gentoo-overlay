# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Tool for rastering image across multiple pages that can then be printed, cut and glued together into a larger poster"
HOMEPAGE="https://gitlab.mister-muffin.de/josch/plakativ/"
SRC_URI="https://gitlab.mister-muffin.de/josch/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gui"
RESTRICT="mirror test"

RDEPEND="
	gui? ( dev-lang/python[tk] )
	dev-python/pymupdf[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

function python_install_all() {
	default
	
	if ! use gui; then
		find "${D}" -name "plakativ-gui" -delete
	fi
}
