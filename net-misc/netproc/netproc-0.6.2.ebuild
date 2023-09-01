# Maintainer: Xoores <gentoo@xoores.cz>

EAPI=6

inherit eutils

DESCRIPTION="Tool to monitor network traffic based on processes"
HOMEPAGE="https://github.com/berghetti/netproc"
SRC_URI="https://github.com/berghetti/netproc/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86 ~arm"
IUSE=""

# Do not try to get this from mirrors...
RESTRICT="mirror"

DEPEND="
	sys-devel/gcc
	dev-util/cmake
	sys-libs/glibc
	sys-libs/ncurses
	"
	
RDEPEND="${DEPEND}"


src_install()
{
	exeinto "/usr/sbin"
	
	doman "doc/${PN}.8"
	dosbin "bin/${PN}"
}
