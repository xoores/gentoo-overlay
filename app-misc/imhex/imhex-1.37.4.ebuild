# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_BUILD_TYPE="Release"
RESTRICT="bindist mirror"

DOTNET_PKG_COMPAT="9.0"
NUGETS="
	microsoft.netcore.app.runtime.linux-x64@9.0.0
	microsoft.aspnetcore.app.runtime.linux-x64@9.0.0
"

inherit cmake llvm toolchain-funcs nuget dotnet-pkg-base

DESCRIPTION="A hex editor for reverse engineers, programmers, and eyesight"
HOMEPAGE="https://github.com/WerWolv/ImHex"
SRC_URI="
	https://github.com/WerWolv/ImHex/releases/download/v${PV}/Full.Sources.tar.gz -> ${P}.tar.gz
	https://github.com/WerWolv/ImHex-Patterns/archive/refs/tags/ImHex-v${PV}.tar.gz -> ${PN}-patterns-${PV}.tar.gz
	${NUGET_URIS}
"
S="${WORKDIR}/ImHex"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-forensics/yara
	>=dev-cpp/nlohmann_json-3.10.2
	dev-libs/capstone
	>=dev-libs/libfmt-8.0.0:=
	media-libs/freetype
	media-libs/glfw
	media-libs/glm
	net-libs/libssh2
	net-libs/mbedtls
	net-misc/curl
	sys-apps/dbus
	sys-apps/file
	sys-apps/xdg-desktop-portal
	virtual/libiconv
	virtual/libintl
	app-arch/zstd
	app-arch/lz4
	app-arch/lzma
	app-arch/bzip2
	sys-libs/zlib
	dev-build/ninja
	>=sys-devel/gcc-12.0
	app-admin/chrpath
	gnome-base/librsvg
	llvm-core/lld
	dev-util/ccache
	dev-dotnet/dotnet-runtime-nugets
"
RDEPEND="${DEPEND}"

pkg_pretend() {
	if tc-is-gcc && [[ $(gcc-major-version) -lt 12 ]]; then
		die "${PN} requires GCC 12 or newer"
	fi
}

src_configure() {
	ln -s "../ImHex-Patterns-ImHex-v${PV}" "ImHex-Patterns"
		#~ -D IMHEX_EXCLUDE_PLUGINS="script_loader" \
	
	local mycmakeargs=(
		-D CMAKE_BUILD_TYPE="Release" \
		-D CMAKE_C_COMPILER_LAUNCHER=ccache \
		-D CMAKE_CXX_COMPILER_LAUNCHER=ccache \
		-D CMAKE_C_FLAGS="-fuse-ld=lld" \
		-D CMAKE_CXX_FLAGS="-fuse-ld=lld" \
		-D CMAKE_OBJC_COMPILER_LAUNCHER=ccache \
		-D CMAKE_OBJCXX_COMPILER_LAUNCHER=ccache \
		-D CMAKE_SKIP_RPATH=ON \
		-D IMHEX_PLUGINS_IN_SHARE=OFF \
		-D IMHEX_STRICT_WARNINGS=OFF \
		-D IMHEX_STRIP_RELEASE=OFF \
		-D IMHEX_OFFLINE_BUILD=ON \
		-D IMHEX_IGNORE_BAD_CLONE=ON \
		-D IMHEX_PATTERNS_PULL_MASTER=OFF \
		-D IMHEX_IGNORE_BAD_COMPILER=OFF \
		-D IMHEX_USE_GTK_FILE_PICKER=OFF \
		-D IMHEX_DISABLE_STACKTRACE=OFF \
		-D IMHEX_BUNDLE_DOTNET=OFF \
		-D IMHEX_VERSION="${PV}" \
		-D PROJECT_VERSION="${PV}" \
		-D USE_SYSTEM_CAPSTONE=ON \
		-D USE_SYSTEM_LLVM=ON \
		-D USE_SYSTEM_NFD=OFF \
		-D USE_SYSTEM_NLOHMANN_JSON=ON \
		-D USE_SYSTEM_YARA=ON
	)
	
	mycmakeargs+=( -D IMHEX_EXCLUDE_PLUGINS="script_loader" )

	cmake_src_configure
}

src_test() {
	pushd "${BUILD_DIR}" || die
	emake unit_tests
	popd || die
	cmake_src_test
}

#~ src_install() {
	#~ cmake_src_install

	# Install patterns
	#~ insinto /usr/share/imhex
	#~ rm -rf "${S_PATTERNS}/tests"
	#~ doins -r "${S_PATTERNS}"/*
#~ }

pkg_postinst() {
	ewarn "Plugin script_loader has been disabled temporarily - see https://github.com/WerWolv/ImHex/issues/2054"
	ewarn " "
}
