# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Language bindings for libdbus, for Python"
HOMEPAGE="https://gitlab.com/ldo/dbussy"
SRC_URI="https://gitlab.com/ldo/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"
S="${WORKDIR}/${PN}-v${PV}"

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
"
