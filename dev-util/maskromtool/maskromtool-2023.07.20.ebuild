# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake 

DESCRIPTION="Little CAD tool for taking photographs of a mask ROMs and extracting the bits"
HOMEPAGE="https://github.com/travisgoodspeed/maskromtool/"
SRC_URI="https://github.com/travisgoodspeed/${PN}/archive/refs/tags/v${PV//./-}.tar.gz -> ${P}.tar.gz"

RESTRICT="mirror"
LICENSE="COPYING"
SLOT="0"
KEYWORDS="amd64"


DEPEND="
	>=dev-qt/qtcharts-5
	dev-qt/linguist
	dev-qt/qtbase
	dev-qt/qtcharts
	dev-qt/qttools
	dev-qt/qtimageformats
	dev-qt/qttranslations
	dev-util/cmake
	"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P//./-}"

src_configure() {
	#~ local mycmakeargs=(
		#~ -D CMAKE_BUILD_TYPE="Release" \
		#~ -D CMAKE_C_COMPILER_LAUNCHER=ccache \
		#~ -D CMAKE_CXX_COMPILER_LAUNCHER=ccache \
		#~ -D CMAKE_C_FLAGS="-fuse-ld=lld" \
		#~ -D CMAKE_CXX_FLAGS="-fuse-ld=lld" \
		#~ -D CMAKE_OBJC_COMPILER_LAUNCHER=ccache \
		#~ -D CMAKE_OBJCXX_COMPILER_LAUNCHER=ccache \
		#~ -D CMAKE_SKIP_RPATH=ON \
		#~ -D IMHEX_USE_BUNDLED_CA=OFF \
		#~ -D IMHEX_PLUGINS_IN_SHARE=OFF \
		#~ -D IMHEX_STRIP_RELEASE=OFF \
		#~ -D IMHEX_OFFLINE_BUILD=ON \
		#~ -D IMHEX_IGNORE_BAD_CLONE=ON \
		#~ -D IMHEX_PATTERNS_PULL_MASTER=OFF \
		#~ -D IMHEX_IGNORE_BAD_COMPILER=OFF \
		#~ -D IMHEX_USE_GTK_FILE_PICKER=OFF \
		#~ -D IMHEX_DISABLE_STACKTRACE=OFF \
		#~ -D IMHEX_VERSION="${PV}" \
		#~ -D PROJECT_VERSION="${PV}" \
		#~ -D USE_SYSTEM_CAPSTONE=ON \
		#~ -D USE_SYSTEM_CURL=ON \
		#~ -D USE_SYSTEM_FMT=ON \
		#~ -D USE_SYSTEM_LLVM=ON \
		#~ -D USE_SYSTEM_NFD=OFF \
		#~ -D USE_SYSTEM_NLOHMANN_JSON=ON \
		#~ -D USE_SYSTEM_YARA=ON
	#~ )

	cmake_src_configure
}

src_compile()
{
	mkdir build
	cd build
	cmake .. || die "CMake failed"
	emake clean all || die "Make failed"
}

src_install()
{
	default 
		
	exeinto "/usr/bin"
	dobin "build/${PN}"
}
