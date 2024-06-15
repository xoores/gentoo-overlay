# Maintainer: Xoores <gentoo@xoores.cz>

EAPI=6

inherit autotools

DESCRIPTION="X11 screen lock utility with security in mind"
HOMEPAGE="https://github.com/google/xsecurelock"
SRC_URI="https://github.com/google/xsecurelock/releases/download/v${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86 ~arm"

# By default xsecurelock checks whether something is available
# and compiles accordingly... So useflags are for pulling dependencies
IUSE="+pam mplayer mpv xscreensaver"

# Do not try to get this from mirrors...
RESTRICT="mirror"

DEPEND="
	sys-devel/gcc
	dev-build/make
	sys-libs/glibc
	dev-build/autoconf
	dev-build/automake
	sys-devel/binutils
	virtual/libc
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	x11-libs/libXmu
	x11-libs/libXrandr
	virtual/pkgconfig
	pam? ( sys-libs/pam )
	mplayer? ( media-video/mplayer )
	mpv? ( media-video/mpv )
	xscreensaver? ( x11-misc/xscreensaver )
	"

RDEPEND="${DEPEND}"



src_configure() {
	econf \
	--with-pam-service-name=system-local-login
}

