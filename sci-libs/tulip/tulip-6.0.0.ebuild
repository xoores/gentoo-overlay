# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Information visualization framework dedicated to the analysis and visualization of relational data"
HOMEPAGE="https://tulip.labri.fr/site/"
RESTRICT="bindist mirror"

SRC_URI="https://master.dl.sourceforge.net/project/auber/${PN}/${P}/${P}_src.tar.gz?viasf=1 -> ${P}.tar.gz"

KEYWORDS="~*"
LICENSE="LGPL-3"
SLOT="0"
IUSE="doc gui -test"

RDEPEND="
	doc? (
		dev-python/sphinx
		app-text/doxygen
	)
	|| (
		>=sys-devel/gcc-4.8.1
		>=sys-devel/clang-3.3
	)
	>=dev-lang/python-3.9
	dev-python/sip
	>=dev-build/cmake-3.1
	>=dev-qt/qtbase-5.6
	>=media-libs/glew-1.4
	>=dev-libs/yajl-2.0
	virtual/opengl
	media-libs/qhull
	dev-libs/quazip
	dev-util/cppunit
	media-libs/libpng
	virtual/jpeg
	media-libs/freetype
	sys-libs/zlib"

DEPEND="${RDEPEND}"

# Tried "Release", but Tulip just fails to build with that - around 450/1566 it stops on some #error macro saying
# that some component was built with Debug and combining these will result in crashes... So "Debug" it is for
# everyone *shrug*
CMAKE_BUILD_TYPE="Debug"

PATCHES=(
	# cmake tries to be smart and detects SIP version by regex-matching three numbers separated by a dot. However this
	# match stops on the first occurance rather than the last one, so it matches the *tulip* version, not the expected
	# SIP version...
	"${FILESDIR}/01-wrong_sip_version.patch"
)


src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DPython_EXECUTABLE="${PORTAGE_PYTHON}"
		-DTULIP_BUILD_DOC=$(usex doc ON OFF)
		-DTULIP_BUILD_TESTS=$(usex test ON OFF)
		-DTULIP_BUILD_GL_TEX_LOADER=OFF
		-DTULIP_USE_CCACHE=ON
		-DTULIP_LINUX_DESKTOP_REGISTRATION=OFF
		-DTULIP_BUILD_CORE_ONLY=$(usex gui OFF ON)
	)
	cmake_src_configure
}
