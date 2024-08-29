# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="This package contains a set of persistent object containers built around a modified BTree data structure"
HOMEPAGE="https://github.com/zopefoundation/BTrees"
SRC_URI="https://github.com/zopefoundation/BTrees/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-debug"
RESTRICT="mirror test"
DISTUTILS_EXT=1

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/persistent[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
S="${WORKDIR}/BTrees-${PV}"
