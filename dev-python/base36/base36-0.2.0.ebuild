# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Lightweight Python library for encoding and decoding numbers between base10 and base36"
HOMEPAGE="https://github.com/DanishjeetSingh/base36py"
SRC_URI="https://github.com/DanishjeetSingh/base36py/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror test"

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
S="${WORKDIR}/${PN}py-${PV}"

src_prepare() {
	einfo "Renaming package: base36py -> base36"
	sed -i 's/name="base36py"/name="base36"/g' setup.py || die "Could not rename package"
	mv -v base36py base36
	
	default
}
