# Maintainer: Xoores <me@xoores.cz>

EAPI=7

inherit eutils

DESCRIPTION="Tool to monitor network traffic based on processes"
HOMEPAGE="https://github.com/berghetti/netproc"
SRC_URI="https://github.com/berghetti/netproc/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

# Do not try to get this from mirrors...
RESTRICT="mirror"

# Ghidra needs OpenJDK 11 64bit
DEPEND="
	sys-devel/gcc
	dev-util/cmake
	sys-libs/ncurses
	"
	
RDEPEND="${DEPEND}"


src_install()
{
	exeinto "/usr/sbin"
	docinto "/usr/share/man/man8"
	
	dodoc "doc/${PN}.8"
	dosbin "bin/${PN}"
}
