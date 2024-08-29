# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python wrapper around rapidjson"
HOMEPAGE="https://github.com/python-rapidjson/python-rapidjson"
SRC_URI="https://github.com/python-rapidjson/python-rapidjson/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-debug"
RESTRICT="mirror test"
DISTUTILS_EXT=1

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/readme-renderer
	dev-python/twine
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
S="${WORKDIR}/python-${P}"

DISTUTILS_ARGS="--rj-include-dir=/usr/include/rapidjson --prefix=\"${D}\""

src_prepare() {
	einfo "Renaming package: python-rapidjson -> rapidjson"
	sed -i "s/name='python-rapidjson'/name='rapidjson'/g" setup.py || die "Could not rename package"
	
	default
}
