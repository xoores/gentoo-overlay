# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python's first meta-framework"
HOMEPAGE="https://github.com/gigaquads/ravel"
SRC_URI="https://github.com/gigaquads/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror test"

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/base36[${PYTHON_USEDEP}]
	dev-python/dbussy[${PYTHON_USEDEP}]
	dev-python/sqlparse[${PYTHON_USEDEP}]
	dev-python/appyratus[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
