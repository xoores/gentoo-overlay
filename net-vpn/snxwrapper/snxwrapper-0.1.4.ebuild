# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

DESCRIPTION="Tool created for effortless and automated connection to CheckPoint's SNX VPN."
HOMEPAGE="https://gitlab.com/Xoores/snxwrapper"
RESTRICT="bindist mirror"

SRC_URI="https://gitlab.com/Xoores/snxwrapper/-/archive/${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

LICENSE="Unlicense"
SLOT="0"


DEPEND="
	dev-lang/python
	dev-python/aiohttp
	dev-python/aiosignal
	dev-python/pycryptodome
	dev-python/pyopenssl
	dev-python/async-timeout
	dev-python/beautifulsoup4
	dev-python/lxml
	dev-python/rsa"
RDEPEND="${DEPEND}"


src_install()
{
	exeinto "/usr/bin"
	dobin "${PN}"
}
