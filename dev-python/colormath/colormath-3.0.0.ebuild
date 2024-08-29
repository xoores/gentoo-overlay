# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Collection of miscellaneous utilities and components used in basically every Gigaquads project"
HOMEPAGE="https://github.com/gtaylor/python-colormath"
SRC_URI="https://github.com/gtaylor/python-colormath/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror test"

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
S="${WORKDIR}/python-${P}"
