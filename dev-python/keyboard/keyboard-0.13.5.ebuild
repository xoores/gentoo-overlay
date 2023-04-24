# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Take full control of your keyboard with this small Python library (UNMAINTAINTED)"
HOMEPAGE="https://github.com/boppreh/keyboard"
SRC_URI="https://github.com/boppreh/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
