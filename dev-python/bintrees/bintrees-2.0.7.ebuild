# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=(python{2_7,3_4})

inherit distutils-r1

DESCRIPTION="This package provides Binary- RedBlack- and AVL-Trees written in Python and Cython/C."
HOMEPAGE="https://github.com/mozman/bintrees.git"


SRC_URI="https://github.com/mozman/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

#RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
#	dev-python/python-dateutil[${PYTHON_USEDEP}]"



#src_prepare()
#{
	#mkdir ${WORKDIR}/${P}/build
#}
