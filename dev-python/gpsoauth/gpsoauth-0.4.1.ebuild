# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="A python client library for Google Play Services OAuth"
HOMEPAGE="https://github.com/simon-weber/gpsoauth"
SRC_URI="https://github.com/simon-weber/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/pycryptodomex-3.0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]"
	#dev-python/pycrypto[${PYTHON_USEDEP}]
